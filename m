Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6CAC44502
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 10:27:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66F0810E18C;
	Wed, 21 Jan 2026 10:27:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v3HHbgcv";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012068.outbound.protection.outlook.com [52.101.53.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BBD810E18C
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 10:27:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOynXewa1UMt8hEaMBy1qVGss0TClA6JgZI41uXr0V5ueiKDFNg1+YzrQKXXnw47lsvY6P0eUbrbb0VqesNHTcXeTw8WczWuzF/7Do//QKrUbCNQBzzTglMT59DNwOVKJPmvVfldnja1iN24ntX737RMly4d1JeUiliOy51fOgB2jYkSGFwO0NHlPtkmYmvqhPaTPJ8r1LHDtwtCEFy+qKAr+z7xFQekTteSFSTelGUrJEi9v3eHZTVx9yXszM99x8uqQPcVDzz3AmXjhH7giqfV20Aei9LolezMS8VqrDdgp/uRdpLwMI8Zf0q+a9t17yO4de6mV66rBEa8cWOl/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnMyfTmNA/qE1nsSjh8zl3YyM6pqdhg98WBvDJczWnY=;
 b=j7DBrS/bD9sbsgUgrDDFd5BgiIu4x8ZqEJvtVvzDyAqM3X2R7i5ZawsnZda1EQNWliZAzD740OflVRTHttJd/bcZ0W3xeA0TLqPqjR6mC/MYerXkgo/clZdCGr1PO9cOQOccZsxaP5NPWg3alVlAEeyaiHenOWdLlQ4NWecRHZD7x0UksrUUdwIz0K3e7E6i1L3oAF1GUox1Tr6MHgI+6XMspFoUQCH/bOF0cS0UFBitYvwrUgmSHFSqdHjVyCsWkXtCtGjGjSdfr8scdqvWdoHyz4KFsa6de0pKUyg3t2hFIKHVw4BKarz7XW3WZFKmYbKXAJaYJMDf57uBOhPaAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnMyfTmNA/qE1nsSjh8zl3YyM6pqdhg98WBvDJczWnY=;
 b=v3HHbgcvZOCIymsGIVMaY8zXNY83JEdEt4XCj7DXCjejIObt/AcfC9a/CCDTtAv0U5UUdSlF4C88/p7sS0ZeVoDaw2glplaDf9+50BGcGfKqUECyRTw8C7sP8Ed9xikRha2z9Rr3N4cpNFuegZRTzbdYe/BiWjbjCfKNWyDePuA=
Received: from IA0PR12MB8647.namprd12.prod.outlook.com (2603:10b6:208:480::8)
 by IA1PR12MB8359.namprd12.prod.outlook.com (2603:10b6:208:3fc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Wed, 21 Jan
 2026 10:27:12 +0000
Received: from IA0PR12MB8647.namprd12.prod.outlook.com
 ([fe80::14ca:b414:8e97:f4c0]) by IA0PR12MB8647.namprd12.prod.outlook.com
 ([fe80::14ca:b414:8e97:f4c0%4]) with mapi id 15.20.9520.009; Wed, 21 Jan 2026
 10:27:12 +0000
From: "Indic, Vladimir" <Vladimir.Indic@amd.com>
To: "Six, Lancelot" <Lancelot.Six@amd.com>, "Cornwall, Jay"
 <Jay.Cornwall@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/5] drm/amdkfd: Sync trap handler binary with source
Thread-Topic: [PATCH 1/5] drm/amdkfd: Sync trap handler binary with source
Thread-Index: AQHchyhdkeaoUbBpIU6v3scoKSzWg7Vbq56AgADG71A=
Date: Wed, 21 Jan 2026 10:27:12 +0000
Message-ID: <IA0PR12MB86470C333BAAEFEDFF8462879A96A@IA0PR12MB8647.namprd12.prod.outlook.com>
References: <20260116203932.988704-1-jay.cornwall@amd.com>
 <20260116203932.988704-2-jay.cornwall@amd.com>
 <d940d047-b5dd-4d49-a45a-aa259aa4a44e@amd.com>
In-Reply-To: <d940d047-b5dd-4d49-a45a-aa259aa4a44e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-21T10:26:41.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8647:EE_|IA1PR12MB8359:EE_
x-ms-office365-filtering-correlation-id: 29b52c2f-0d75-4f2a-2fd3-08de58d7a3d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?eFJ4ZTM4dlFaazBSZGVha053dkdmdTIvV2pwRjMxbm1DSWtCQTlNSGV5eVRF?=
 =?utf-8?B?YnhCOGZkMi9wZGY5Wmx3cE9rTGZEOERRWkQ5WHJTc1B5N2dMNmgzRGE1SmVO?=
 =?utf-8?B?VEVtKyt0Y0IxTUFLTU9VZzJUYTE1YVAxRVRveXlWNEgwc01RVlJQV0NEWkpI?=
 =?utf-8?B?MlFVK3kxQVZFSmczL3lYcEtHNTQ4TGU3dDBhR1lBNTkrYmhiVy9Hb0VHczRW?=
 =?utf-8?B?Y3RiZVFkU3RTR1RxOCtQb0NWdlZSaW9oMWZQOW1xV3kxd0tVYWw2L3RpNmlR?=
 =?utf-8?B?UXFmdCt2MldkaW9RbStNS0U5OS96ZXMwRFphZ1djQnZ3ZlkxNWNlSldQQ3E2?=
 =?utf-8?B?V3pYWkVCNjFwRjV4bStmK3ZkN25jUXM2THVoUGEyS3NYSFAxMll2TVIvL3B4?=
 =?utf-8?B?R2hscms4NVBoVFJYdWhhc2V6ZmpMRm9tSlZyb2pTNjUyRXNmb3cyaXNnb3gr?=
 =?utf-8?B?cG56UE9JNDAwQ2sxTnRyTWR3bHFsazE1OVphRGN2UW1FMkNSVCtRUS9GU1oy?=
 =?utf-8?B?SHB6M21qZGp2ZmZybTdFcTBqWEFmdG9uNjlnTFpXQ0l6TVY0SkU5dFcyMWtZ?=
 =?utf-8?B?WXg1M2E2UWVKdDJsZjNsVmx1UWFlMGlOMXdkL0hJN1llbFdBMWhZUmYvZjJC?=
 =?utf-8?B?L05rM2Q0M0g4dUlwYlpjTmxoQitkYWI3V2ZWbE0vZzZoZHY5NnpzdHdTMHlX?=
 =?utf-8?B?VUdETk4ySXI3STg4RVFWcjUzL1V3bVdzZVRIdTVBNzgxYmxVZDRnYWxVVFcy?=
 =?utf-8?B?RnhzKzBxTTRNOUNNQ3hHREVRNWxCeFhIcHNvWEdQbkh0Qy9pNWh1WFdUSkF6?=
 =?utf-8?B?SExrSFF2RDlKL2dvOHpYUlZ5Y0tuZlpVWGxwakNTOURWbDY3eUxJbkEySlpK?=
 =?utf-8?B?TnQ4V1JnWFMyeHQydmtjcGdDWWJiZDJ0MzV6Y3VMN0RpdVRST29neTM1RGJo?=
 =?utf-8?B?dXFGYXJ4bWhXYU9wam1YR1lDbU9lQ2dESmlONzY5TXoxbGlDbUlHWWtHOW9W?=
 =?utf-8?B?bkFuY1MzT0UxMXlkQ2c0S3JFUHlvbEh5NXpHM2FUVDVXbkQyZ01uZVY0N3Vo?=
 =?utf-8?B?YW1mZ0prejJBTmlQd0dYNDJJc0dPdWhIS2JmY1FqNFJJWjN1UzdjWVpLM2RY?=
 =?utf-8?B?Nmc5aTJSWjA3MjV5S2phUHBHcENsNTVOWWphU0tmeWxPNStyT0puNTdmOXBV?=
 =?utf-8?B?dGcxWDlJSDVCRUJBbFBFUTJUb2tDU0dtVzdnT2lBMzhGZUs1c0VDVGkzYkZN?=
 =?utf-8?B?Mmc0S1hXRlpsWUhDQ1NLRCsrZW5BR0NhOVkwUEpFckxxZnlGMWgrK3lhSmxM?=
 =?utf-8?B?SVJqTEEzeTRLblJESWtnT3MzQXliYTlhNWdUSDMyTWRJcDRlMjEzY3NwWmU4?=
 =?utf-8?B?aEpXSU9TSXE4UWxBZGQzSm1Wc29KZDlMRjZlTldLNFdod2hjdXVLZitZa0kw?=
 =?utf-8?B?blM1ZDJUeEtpYnFYYk16K3l3ZEU2eDAvbFVkVmxnekJEZTJzYWQyMnptR1NU?=
 =?utf-8?B?MWNUa1VNRk1HZHpCYkZOT21tOWs5Wkg5M2JoMWl0eC8rQzA3c3ZpR2JPS2lW?=
 =?utf-8?B?UFcxV3VCWUMrTWpiK0xvZVFKenRQTkkwMlJDWXUzcXV4QzgzU0k4aHNtdDFQ?=
 =?utf-8?B?MmRPd3J5enQrZUplWFRleEk2QkRzYWY4SW9GMHBUZHVpYjgvdkliWjRTc0c0?=
 =?utf-8?B?MThkaUpET0VkSk5ieGFtQkdhN01rb2dRZGxNYy9GaENOTlNneENzRXVkYjV6?=
 =?utf-8?B?U3Q0V3VhRTlEenBiZFljc21adjNrY2tmalBJSlNJK0N1V3grcmNrK2wrbldM?=
 =?utf-8?B?QkF5Nitpd2hsYmNPczNlUldPblNNNTZBVmJXUlV0ZkYyY2RtZVJyUG1RVTJo?=
 =?utf-8?B?TjFZUHhZMXQ4c2NURHUzY2c0dlNOMWVZcFBTUTFkU0dXOFIvWkR4RGRhY1FY?=
 =?utf-8?B?WE9KaEx3ZGIwbjh6NVovdWNNeEdLcSt5d0xGYXNOTStZS0s3d0o0ek9QZC9O?=
 =?utf-8?B?QSttS0w3dUJVODJ3NlhuYndBS3M0YVNZMEFNS3BGemN0bFlmMjhNSVdSU1kw?=
 =?utf-8?B?d3hLWG5TdE56Q1JldWFyZWNtaUkxeUR6YVVwSVBOOHorcGdmTkZZYTFUZVlW?=
 =?utf-8?B?WUppNlE5WE9KWHcxR2diNEdlc09lNzhCdG5DWmpBckxocWdncE5Tdzc2UEt4?=
 =?utf-8?Q?KipFdE453Kq0jgFpyaE0nX0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8647.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVJsbjYwajJ5ZEF1YWRqOGVJcU03MjFKNnNFdlFNUnpsY2Q5VmVKQjAyWkFU?=
 =?utf-8?B?dWFKZHJaTU5Nd1BDWDhxSVFoZjA0eDFBUHJJVzkzMXpGRkx5Tlp0UTVlamdl?=
 =?utf-8?B?TGhnWVQvZC9JSCtobTJTdFV4NmRoRjdiLzk2SW9YZC81TzdMY1BTU1RhWFJI?=
 =?utf-8?B?ejEwWlNxSytxOGFmRVdVNWptS25kUTFqVkJRU3pLRTBPczJwWGlpVStSbnJk?=
 =?utf-8?B?Rkc1UWliQlFMVGYwODA2Ni8zSXdiK2dvc2lMblZySk84aXc1ME9MQmY3cGY1?=
 =?utf-8?B?akdvL0hzdzIyTzQvZXdPbEIzZWowZm95dW8wMG0vS21WdU52YnAyN0tBN3FM?=
 =?utf-8?B?WE11QllCUG1HUXltWVE0MG9VMVEyMnFTYnI3ZklRRVgzNXptNk5UZ2wyVEEv?=
 =?utf-8?B?S1lVa0NMTytPMW1DaFZURlZnbms4N1prUW91YkV6TnhNS0pMWG82T3NUb2dO?=
 =?utf-8?B?N0tWRmFjSDVWS0VLa0RWbzI2cDRiK1pOTHhocjZZYk5ZWmJYTjVmZEUvWVM4?=
 =?utf-8?B?QU4xNXI5T2xraDBnVGE4NS91Y2lkWXhLRFNZK0QxbUtFV0xPaU1pbXM3MUM2?=
 =?utf-8?B?WUhoVSsvZFlyN3NsMk5mOFMvMkk2TWYzSmd1RlUyL0dCUFNkKzRiczNMUFBF?=
 =?utf-8?B?M3E1bjJHb2Q3MHZTdFo5QU1qTVplVlU0cThibXJ1S3RTTU1HZEg1YUp1TG5F?=
 =?utf-8?B?ZU54L1NSYnl2MmdLV0pwV1EycEZuSlJRWU9kNlR3UjhNanhZV3ZhYXlEUWVu?=
 =?utf-8?B?ZzFNdGFBY2xKdVpNZjFlQlpqNlpVQlN1bzdLbVhBSkI2YnczTkFQTDdkbFN2?=
 =?utf-8?B?ZkxqOGpsVGQ2UHB2SGd6V080d2hLcS9kcWJDT3JZMnZDMGx6NG9XL3VNL1dN?=
 =?utf-8?B?WXlURzh1NmlnTHR2UktaVzVMZXN5RjJOYU9lOVRvN3J5djBpWUZiSy9UUTZq?=
 =?utf-8?B?QWU3STBtV01LZ094WmNiMmwzZmg1UGxQRUpCVkhhMnoranJkTU5kQjZQSDk0?=
 =?utf-8?B?TFg5WjViWllRN3FNa25rQllZM294WVRRaDQ3YzlUbGROQnluamlNZFdFNUNV?=
 =?utf-8?B?YnlsRVJ5SitzanN4ZGRxT0V5WFNRT0kvMnlPNHlybUxZb3VQU2VDdm0wNmY4?=
 =?utf-8?B?a1BDaXQ2Z3VKbVY2dGhYdWJOWWROeThqTjJZb2JhZGNLdkU3NGlXemJobWFC?=
 =?utf-8?B?VHpTRXhPbHUwcGVYQSt0MG1WUm9xRWh2cFRHbktLYXlyUFc3ME43a2xNM0pN?=
 =?utf-8?B?RmZsMUNicGU5YkU1SlYvMTZoZ3BLMGZEMllTbXN1WmJtV1JvTnhhSG8rM2Qx?=
 =?utf-8?B?cTFINHJiR2ZxOUVmbVVPQWY1ODg5QzNQRmE0c1JTMmQvdVp0Tzk3RnY4RzZB?=
 =?utf-8?B?UllFR2RKYkIwRVg2NWlndkE0dWZaVzNRcCtETVp0R0diTnF1NUk1cURzeUQ0?=
 =?utf-8?B?Yjg1dis1RkF1dU55YlV1TlVjV1F4SnJQbUI5aWlIWEQzMXNabU9RcmdFVDBV?=
 =?utf-8?B?TmpOOHVKL0JodURxT201bDVnbGxuUWVXdi96Ymw5WitQdXEzQmIweWptSmNO?=
 =?utf-8?B?aHJlb29SeVlxc252aGh4bFJSL2VzeGwzeUJZWnZ6RkdSRlNySHl0eStwUU9W?=
 =?utf-8?B?MjF3U2JMNitiNlRKNUVRSGF1Rk42S29pMm5RYzRVUzNFWmZWMVNzcU0xOUdH?=
 =?utf-8?B?VTRPaC9XWEM3N3I0bHhTNFdTSUUyNDVnTVd5cndQSTE4VXBJaG13Q2hGcURE?=
 =?utf-8?B?ditMcnlhZitEU0liNzNMaTlGenZtOXM5K2NOZ3lBTWhtcG84SzdqZGt6MXFC?=
 =?utf-8?B?Q3Erc1NVdkxZUmFzVk5mKzI0b3ZqQjZRZnpFR3VURGlhTk9yMitnM3VVUnBV?=
 =?utf-8?B?NTJMR0x3ZG1XQTNkWEJORUE0YW1SSy9qbDJLQmc4RExzTHNlN2U0YXlkN0E1?=
 =?utf-8?B?SXpPSTFVeW1IS0VWQVpMQU85RE1uOElYbksrZkxCSzgvZFN4UWZTcDJrQWFz?=
 =?utf-8?B?cjdxUFlZcFhlM0FvY2hKdHBzSzJSa3RiNi9YeWlCZVUvSVAvQ2RKWGJnbzFQ?=
 =?utf-8?B?dlpxRmtlVVlRV1ZQM3BHeldCanlESFM5dVQyZ3d5bm1EM1ZSd2hmMEVnUld4?=
 =?utf-8?B?cmphcFRlNi9laUIvYWJ5Nm43Z3MxcFZ0ZTJWd2FHbmJ3MWJua0NLV3dNdE9B?=
 =?utf-8?B?MWZNcTYxYUJuQ3NTUnZxYTBYa1kvT1dqcllMTlRmRFRaSGVTNytMbmR3NDR2?=
 =?utf-8?B?Zy9neXpjNlNaNEpGcGI1UmVVSVltVTJJdWJ1T2VhMFpSVEJtZkptV0U3SkQw?=
 =?utf-8?Q?wIZzND48LJRx82iQoz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8647.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b52c2f-0d75-4f2a-2fd3-08de58d7a3d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 10:27:12.2634 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Is/PsU14L5udFqI5gsToerLTGPpxixx6OnnQfcxYiq3KbaMTzcAubtAprIrF0cX7Uope1UebmLNzUVLdkUHIDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8359
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KQWRkaW5nIG9uZSBtb3JlIHJldmlldywgdGhlIHBhdGNoIExHVE0sIHRoYW5rcyENCg0KUmV2
aWV3ZWQtYnk6IFZsYWRpbWlyIEluZGljPHZsYWRpbWlyLmluZGljQGFtZC5jb20+DQoNCi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBTaXgsIExhbmNlbG90IDxMYW5jZWxvdC5TaXhA
YW1kLmNvbT4NClNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgMjAsIDIwMjYgMTE6MzUgUE0NClRvOiBD
b3Jud2FsbCwgSmF5IDxKYXkuQ29ybndhbGxAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQpDYzogSW5kaWMsIFZsYWRpbWlyIDxWbGFkaW1pci5JbmRpY0BhbWQuY29tPg0K
U3ViamVjdDogUmU6IFtQQVRDSCAxLzVdIGRybS9hbWRrZmQ6IFN5bmMgdHJhcCBoYW5kbGVyIGJp
bmFyeSB3aXRoIHNvdXJjZQ0KDQpIaSwNCg0KVGhpcyBsb29rcyBnb29kIHRvIG1lLCB0aGFua3Mu
DQoNCk9uIDE2LzAxLzIwMjYgMjA6MzksIEpheSBDb3Jud2FsbCB3cm90ZToNCj4gQmluYXJ5IGFu
ZCBzb3VyY2UgZGVzeW5jZWQgZHVyaW5nIGJyYW5jaCBhY3Rpdml0eS4gU291cmNlIG1lcmdlIGFs
c28NCj4gaW50cm9kdWNlZCBjb21waWxlIGVycm9yLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBKYXkg
Q29ybndhbGwgPGpheS5jb3Jud2FsbEBhbWQuY29tPg0KPiBDYzogTGFuY2Vsb3QgU2l4IDxsYW5j
ZWxvdC5zaXhAYW1kLmNvbT4NCj4gQ2M6IFZsYWRpbWlyIEluZGljIDx2bGFkaW1pci5pbmRpY0Bh
bWQuY29tPg0KDQpSZXZpZXdlZC1ieTogTGFuY2Vsb3QgU2l4PGxhbmNlbG90LnNpeEBhbWQuY29t
Pg0K
