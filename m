Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D789CC3DA42
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 10:15:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A82710E718;
	Wed, 10 Jul 2024 10:15:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jurkLrFN";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1CC010E256
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 10:15:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3X+56ViOcKl0XI3hsrqeBXLq9QvcIGSsZvgsvrHGrtQ0EVrWKe27yOOqm8R9jHYlG9YzG4eFEaAGwceLkXLU0NDDSbDuE0nrvRJGgDQISPscUbybzhCGErK95AR5ueYlw6nPf9I2Rbf5mizuA+Qjp93H2vQe9tE0RXKs16psCqIzTeYzJoOMw4CXz28QjtaTpdfNCFI2rPolLF1Q1r9Oapy0z/M6Kt9mEeZna012rSh9wf1J8qOAYffBHo9sOVvqmsooy237qO5RYpDz/H6cB6ZHjfBxDvCdcxmIy7tMD6Lk6Jbn8Kp7Gem6XNti4qQglk+x4WOdWkoJOeNkYpVkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/7pMFDaFOnCZCKlepHVninvl7X5AQl21eICdcnh62I=;
 b=MEKNi2cCg7OpkCpufCwyT9ZLyvzHiHqpjEmlPJtDGZShf+C6IsMnKWuOWJXv4zMwU6Jyeb81GRWPyqD2NyJ2e8THpjTpNOlvjVYSr8LUO8rles50f5kdtBIELh+Mf+L3TirRY6KBhIGaVDr/xa8zCTqG85EhSB5DirBo/Jcvvu0OzFFEZ8mSISYtuYRv04hI0SilIPsw+wdMENwZ4WP1ckKHpsiUCv1f28iau9PwKQfZQuC9OU5+6R+eZKSfcaYZ3Qh7+pcfleNjrEKpjDcfSm3sy0W2M18lbc1IS02ouIocNI37JfvcQUTJkuWZ47bnFqbGysQIFFe0G0pDZTsZ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/7pMFDaFOnCZCKlepHVninvl7X5AQl21eICdcnh62I=;
 b=jurkLrFNv4nt0FPaykKKkJbVZZE29wRsFr9R+2iFR3P158B/L71HTMsAGXXip96UQS5ao5by840m2RBAW8YRysCV7SN5sWScNpejSF2jhLqwt2G5JqNGJnNhoPIoRaykar7LAKMds9SbuKQuhwLwH2FSIyr7vlPCDN8JQIMxQBU=
Received: from DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) by
 PH8PR12MB6700.namprd12.prod.outlook.com (2603:10b6:510:1cf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 10:15:44 +0000
Received: from DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::cda7:a979:580:83a]) by DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::cda7:a979:580:83a%7]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 10:15:44 +0000
From: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: set start timestamp of fence in the right
 place
Thread-Topic: [PATCH v2] drm/amdgpu: set start timestamp of fence in the right
 place
Thread-Index: AQHa0mCWFUQC/0nImUSF+KOPpXpAvrHvjZmAgAAJeCCAABrpAIAACQ1Q
Date: Wed, 10 Jul 2024 10:15:44 +0000
Message-ID: <DS7PR12MB6333A502ED4D41239EEB86C8F4A42@DS7PR12MB6333.namprd12.prod.outlook.com>
References: <20240710003101.1645322-1-jiadong.zhu@amd.com>
 <0e79392e-1e82-4602-8ebb-2dc9d31e001c@gmail.com>
 <DS7PR12MB633361A48187FDC04193B93CF4A42@DS7PR12MB6333.namprd12.prod.outlook.com>
 <3f6f779d-33ff-4cbb-9eaf-035888c200e5@gmail.com>
In-Reply-To: <3f6f779d-33ff-4cbb-9eaf-035888c200e5@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=013c0bae-5fab-4994-861d-5f47d92d636a;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-10T09:59:45Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6333:EE_|PH8PR12MB6700:EE_
x-ms-office365-filtering-correlation-id: 877721ed-4933-4874-cb46-08dca0c94244
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eVpqTlA1ZWtpSGRWS21CNGhZa1JGd1NkNGVrTHRwb2hUYlVMMUVGRjBoaGRY?=
 =?utf-8?B?M2Nzd0UySmQ1ME15L21CU1UxaStHSUNJZFZKZHpPcmp4dEtCMGM4ZGMrcmZI?=
 =?utf-8?B?SnZQSTVxSmM0YkhLaGVKdGpBaGVDYjlBRFJEL3dGalREaVgwNklQSzJVeE4x?=
 =?utf-8?B?Y3pVSFZxS042a29CUTFkSU0wSjFyZlBiU3Q4b295d0VTTExBZGZ3aUZVTjVV?=
 =?utf-8?B?d3h4bXBGOEpnVTFRaEd5NW4yVll2OXpjMzhCeEk5S21EVXp2Nk5xMFBDdDhy?=
 =?utf-8?B?aUhMUG52NlowaVVXY0FIVHoxTkp4K3dhUnRzZ1dtUU41cXdDTmkyMzdtSFI2?=
 =?utf-8?B?U3dqdDZ3NWJFelNZRXhkRy8yZFh4K2Q2ZUpoa05pSXhoZWZxdDJZeXFpekZ3?=
 =?utf-8?B?RjN0djhMTWN3WDJ6VlZUNjlKYnZVVG1BbHB5NXNvNzRKS3dDeE9JYWZFajFl?=
 =?utf-8?B?LzlFeTRGSEFnRGJjbVNRd095RWkzYUR3eDRKT0ZQRS9zbndHT1N6RWVOSmhm?=
 =?utf-8?B?eHZGdHVEaXF5NEtOQXRLNEhYTjlZL3F1a0Y0bGh1WkdrSkRUTWNFNmxRR01q?=
 =?utf-8?B?QysyaWlYT1BRTkZzT2dTQ09OUkJkbDdKL1lyUVZKb0d3OEhyd2V0QnkvWmxz?=
 =?utf-8?B?cjVQSXRXallNL3gwa1pLbURSVEZNaWNBWjlpWGxualRsbCt0WUROUFJXczQ5?=
 =?utf-8?B?UitIRm5CNmZVbVczYVRNamh6THBTbzFnNHJtYlZ0TGp2UE90R1p1U0tDSGFE?=
 =?utf-8?B?OGtmWGtNTTFGN0ZaT0NvWFc4bGZHRUw3bTU0cU95Zk9XUDZ0UldJczc4OW0z?=
 =?utf-8?B?NEV5ODZPVnRRdFlWTU02cmVmN1FpQ3hVVU5FeHpVYnlTRG1yM21sdHU1b1lJ?=
 =?utf-8?B?OWtKZ0pBQUQxM2Zxc21tQVJNSVVoVzhGM0J0cnNTMUFEQlo2d1NKTUFyMzdK?=
 =?utf-8?B?dUpkTE9qdUhSVmtFMzFvTlkyeDJ1THBTUW1uZXQvZmtuYUFGZWFDcUNTNEpK?=
 =?utf-8?B?eGI0QWhFRmw4UW1tY3RZZ1c1b1l2Q0M2RmFmakg5NGljUCtMU0diMzRyT0F1?=
 =?utf-8?B?NHh3S0tUT1pSTTVZbU9zK05zbnl3bjZ0UVNtd1pla0Z5VDNiZzBLVlkwcW5J?=
 =?utf-8?B?ckl5cGsvSWV3Mkh4VjdwWW5hNWJldlcwSUdTd2FKbmtxTUU5UDhkWk5WL21B?=
 =?utf-8?B?ZUl6WUhQVjNya1B2NHhxZVEzNmk0YjQzcDFFeFJmOUpZek5wTmZXNTUxaGpu?=
 =?utf-8?B?OXVHVWlTcDZXcHZ6YnJVTktjOW84N2NzVDUzSE5ZdFpPVVBDVElYSW93YnB0?=
 =?utf-8?B?K09Uak0xb2xBWnJoUHdDbjBXTnYzUjRyWEVPZjdkRktHUmczcmJ1SmE1OTJY?=
 =?utf-8?B?cXo3SFBXMTZJMXpVeFVVenlRZ0QvUDdvMUtDa3Yxb3N3Q0hTSzA1SnFSKzla?=
 =?utf-8?B?Z1R6SXd4R0twNklhRnNYTG5oVWpMZ1V3b0dFMzQvbjhhVkN1N2d3T3hqdUYz?=
 =?utf-8?B?UEhaWkVvZ3dCN096Ymh4UVE2Tzkxc3EzVjd3aCtaVnlpdHpKK1htWGtQRmNU?=
 =?utf-8?B?ZkJCTzFlaUowUlkrV2RPQVU1YndiNVZvV1RNZDd4REhiQnRjOThjSFo2Tmpt?=
 =?utf-8?B?V2l3STlNbGgzZnBGdUdKUE1hOWMvUndFcUNiaDBDSVBHMXl1bGRIZ2xqL0hC?=
 =?utf-8?B?azZGYkZLTDFJZ0NWb0k0Qm5iQ0s2L2dxTklLbWEzZXJyRjdHVXY1cjBBc1dQ?=
 =?utf-8?B?SW83cTlRZ2l0cUllREZtMEppNmk5ajAzTTUrTnJzSWVzd1UwTGZBSThEWEhI?=
 =?utf-8?B?ZjRPYVRLZm16Q0x0SmlaSVF3dWJoSmtwWGZ5SWRxemg4cEUxZnNzc296Vk1i?=
 =?utf-8?B?L1RReG1aOWlxbXRCcWxIeDNBcGQvcGkvaWVYSndOL1ZhMVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6333.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Znc5OWZQR3BqVFkvUlBnYVlYOXBlY2VpbDd4Nmp1YU5NTXo3cE5EVTAydkcz?=
 =?utf-8?B?TDNscDRXS2NiQUVpTnVQRVRuTENxY3d2NmlneFdqTmdhMDh1bmh2Umg2UjZi?=
 =?utf-8?B?akpMRVZLMHp3bjM3WElZMW1OblNRS3E1R1QyZmI4Qmk4SElnWHBSa0wwR0RP?=
 =?utf-8?B?QWhkMW5qaGR4MHRPY2NuOVlkSEtPSnJtNE5TaU9wcW9MQU53eWxkYkZPQ0Rn?=
 =?utf-8?B?THF1ZXM0dEdnNEZDREtPV0h6c0ltTXh1RUZ2NDZFVXlsWFY3RU9PcENveTl0?=
 =?utf-8?B?Z0lDM0ZUeHllbjN1QXB5VUlkMXNNY0ZXaXdEZ2JrZmJMQ2tvSmVNZ0xObVVJ?=
 =?utf-8?B?QWRDVWVpRmgxNzMydXFFYjQxU1V0Q0RSRC8vWjhQVkozOWkrYndEQUhsbGVC?=
 =?utf-8?B?eHNNZk9rbEtPbmNMdlpqYnd1dVZaQUZNU094QTk4RXpXcWpGVjg5MGkvVm9t?=
 =?utf-8?B?UGIrdnpRQUlnSkZ5RnpjMzNIZ0w5M3dIaVJOWG9OSkYwa091elMyRzQ3SVBU?=
 =?utf-8?B?aGJLalRpRUsxNWJYZnNtU1FJcDhSWVFDZ2xrS3Q3emRCenEvNFdvaS82RWV3?=
 =?utf-8?B?S2trOVdSTXNvb1pKTEEwckttdTdRN1hxMSt3Y1JDdTdPeE9PRHNGeUlxdng4?=
 =?utf-8?B?OEpPTW1zK2l2ZTQrUzN4cUIrNVhyTUtsb3o4dkdYd290Nld1WkJ2Z3VBcUNR?=
 =?utf-8?B?NW1HTnkrQ2tiU05xK2czd1FWSCt5Qm5DUFJ5dElrRGE2a3JoSWkvdFIxakhM?=
 =?utf-8?B?N1ZBaFVsRlhYdjRnTFdBOFg2Ry9OenVMVXEwQ0lTa2U2VHdvYXVLbXNMNzZR?=
 =?utf-8?B?K0NhaHdjZytUWWUrYWhWR0NURVg2YXBoNzMrUUZPdnFLV2tmaU04ajc0Z0M1?=
 =?utf-8?B?VzJBVVFpbXg4bU1jMGQvdWRwZFZaRFJzc0xHakw5dG5ybDZONURTT2JnNW9Z?=
 =?utf-8?B?eW5vcXJjWlkzTTUyUllSTElKTHlITWFMSmFwSzI5N1F2Vk9WQUFMNWJPOURn?=
 =?utf-8?B?RmVZNURFT1ZVSXNrTjNEZTgzYUExbG9JZTIwL0tKa1dMQWdmNVNmaC9sMkFS?=
 =?utf-8?B?VmlyWG1OZjd4RU5ISHpkYjd1ajZBZUVXRFlnWjhNYmtBbHpBQW9qVC8yWGJU?=
 =?utf-8?B?NjdybEpjMWhNUEVXREZLRlRIUStMb2I1M3dtbExnR05mdXpDRmhHdDR6WHlq?=
 =?utf-8?B?YXM0aDhtZnVnODQrdWE1Sms4QmlEWnlKZkZFbU53eW9ZL0k2RmxtRmtMYUVy?=
 =?utf-8?B?cS9lQVFSSkdnQ2h5aWo1QzJmczZSVVhRWXRuNkE0ZHN0ZlZFWVB3cnFrOFVO?=
 =?utf-8?B?KzkrSlo0cWs1cG5lVXpVUUJRZktoSVVMeDVWdW9VUk83cUZxMWhqNnhqUXVh?=
 =?utf-8?B?SnQwUUhLOW5kMG1kWUhUb0tEc0VSMTB1TkNOalN6QVZhdVNJQ2t5Nm1jdTQy?=
 =?utf-8?B?bjBEUTI3TmI0SllHaEc3VzBtVGlsa21mYmtRbHhWUVF3L01abkFIemJrenFy?=
 =?utf-8?B?a09WYnZybXlVS0FYTHFGNzNBcnJ3My9tUXhwZWxQbXpuWGtmNnVvSGJGQitF?=
 =?utf-8?B?dG5la3kvY2VGbm5lZmhlMnBUQVNwUTZ5aS8wdHJEYzJ1UWU0ZFhTMkdyTGFz?=
 =?utf-8?B?VVJJQ1NtSk51ejYrcjlKcWJ5eHRsRk82QlBTTmNySHBlaXFIbjhPUnRMV2po?=
 =?utf-8?B?eThiK0YzMkRzbEhsekpCdFF4bGg2Tm82Y1NkTDBONWZrZzRaUGlvQTVkR2RG?=
 =?utf-8?B?cG11dU55amIrdFRlbXVxSy8yVnA1TG13Tm5DeEFMd0lJVm5wNkRNeStuQ3FI?=
 =?utf-8?B?WjNnU2dLMExYOTc2NWsyNmZUNC9OU3o3L2JaWlI3Y0liREgvOSthT3VDdk9w?=
 =?utf-8?B?MmNEbkR1eUxCU205OUpqQTJlOEE0bmZTa0kzZTBYMUs0L1AzdGtoNmVYdy9w?=
 =?utf-8?B?ZGlxN0NLMkpRYndlYVNhMnhWN29YNE9wQzZVQ3BGaVNIVDZpSTBnYWFlNHZt?=
 =?utf-8?B?VkJ4ZDEycHhtMnMzcFFrTVE1OGJaYnNUOUlzbEE5SG04b2wwSXJkQ2xUbDZL?=
 =?utf-8?B?ZHc4aG9LT0hQelBsTmhla3plTnpHVEd4ZE1NbkNQVHcrVkdMNU9aeTk5TThl?=
 =?utf-8?Q?ET3Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 877721ed-4933-4874-cb46-08dca0c94244
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 10:15:44.0317 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qZCXVEBhbpVFc8MhSoObmKREc+l9ajdJeFAKVs4atQ0GhOk72CxriCmXiBxwkmKtVd799jSSUjkazEdBdW+yjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6700
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaHJpc3RpYW4gS8O2bmln
IDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBK
dWx5IDEwLCAyMDI0IDU6MjcgUE0NCj4gVG86IFpodSwgSmlhZG9uZyA8SmlhZG9uZy5aaHVAYW1k
LmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOw0KPiBEZXVjaGVyLCBBbGV4YW5k
ZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJd
IGRybS9hbWRncHU6IHNldCBzdGFydCB0aW1lc3RhbXAgb2YgZmVuY2UgaW4gdGhlDQo+IHJpZ2h0
IHBsYWNlDQo+DQo+IEFtIDEwLjA3LjI0IHVtIDA5OjU0IHNjaHJpZWIgWmh1LCBKaWFkb25nOg0K
PiA+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBBTUQgSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9u
bHldDQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+DQo+ID4+IFNl
bnQ6IFdlZG5lc2RheSwgSnVseSAxMCwgMjAyNCAzOjE3IFBNDQo+ID4+IFRvOiBaaHUsIEppYWRv
bmcgPEppYWRvbmcuWmh1QGFtZC5jb20+OyBhbWQtDQo+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcNCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gZHJtL2FtZGdwdTogc2V0IHN0YXJ0IHRp
bWVzdGFtcCBvZiBmZW5jZSBpbg0KPiA+PiB0aGUgcmlnaHQgcGxhY2UNCj4gPj4NCj4gPj4gQW0g
MTAuMDcuMjQgdW0gMDI6MzEgc2NocmllYiBqaWFkb25nLnpodUBhbWQuY29tOg0KPiA+Pj4gRnJv
bTogSmlhZG9uZyBaaHUgPEppYWRvbmcuWmh1QGFtZC5jb20+DQo+ID4+Pg0KPiA+Pj4gVGhlIGpv
YidzIGVtYmVkZGVkIGZlbmNlIGlzIGRtYV9mZW5jZSB3aGljaCBzaGFsbCBub3QgYmUgY29udmVy
c2VkDQo+ID4+PiB0byBhbWRncHVfZmVuY2UuDQo+ID4+IEdvb2QgY2F0Y2guDQo+ID4+DQo+ID4+
PiBUaGUgc3RhcnQgdGltZXN0YW1wIHNoYWxsIGJlIHNhdmVkIG9uIGpvYiBmb3IgaHdfZmVuY2Uu
DQo+ID4+IEJ1dCBOQUsgdG8gdGhhdCBhcHByb2FjaC4gV2h5IGRvIHdlIG5lZWQgdGhlIHN0YXJ0
IHRpbWUgaGVyZSBpbiB0aGUNCj4gPj4gZmlyc3QgcGxhY2U/DQo+ID4+DQo+ID4+IFJlZ2FyZHMs
DQo+ID4+IENocmlzdGlhbi4NCj4gPj4NCj4gPiBUaGUgc3RhcnQgdGltZXN0YW1wIGlzIHVzZWQg
Zm9yIHJpbmcgbXV4IHRvIGNoZWNrIGlmIHRoZSBmZW5jZXMgYXJlDQo+IHVuc2lnbmFsZWQgZm9y
IGEgcGVyaW9kIG9mIHRpbWUgdW5kZXIgbWNicCBzY2VuYXJpb3MgKGJ5IGNhbGxpbmcNCj4gYW1k
Z3B1X2ZlbmNlX2xhc3RfdW5zaWduYWxlZF90aW1lX3VzKS4NCj4NCj4gSSBjYW4ndCBmaW5kIGEg
cmVhc29uIGZvciBkb2luZyB0aGF0IGluIHRoZSBmaXJzdCBwbGFjZS4gV2hhdCBpcyB0aGUgYmFj
a2dyb3VuZA0KPiBvZiB0aGlzPw0KPg0KPiBSZWdhcmRzLA0KPiBDaHJpc3RpYW4uDQo+DQoNCkl0
IGlzIGFib3V0IG9zIHRyaWdnZXJlZCBtY2JwIG9uIGdmeDkuIFdoZW4gd2UgYXJlIHVzaW5nIHNv
ZnR3YXJlIHJpbmcgYW5kIHJpbmcgbXV4IG9uIGdmeDksICB0aGUgcmluZyBtdXggY2hlY2tzIHRo
ZSBmZW5jZSB1bnNpZ25hbGVkIHRpbWUgb2YgdGhlIGxvdyBwcmlvcml0eSBjb250ZXh0IHdoaWxl
IGhpZ2ggcHJpb3JpdHkgam9iIGNvbWVzLiBJZiB0aGUgdGltZSBkdXJhdGlvbiBleGNlZWRzIGEg
Y2VydGFpbiB0aW1lLCBtdXggd2lsbCB0cmlnZ2VyIG1jYnAuDQp3ZSBjb3VsZCBhZGQgYWRldi0+
Z2Z4Lm1jYnAgY2hlY2sgd2hlbiBzZXQgc3RhcnRfdGltZXN0YW1wIGZvciB0aG9zZSBmZW5jZXMu
DQoNClRoYW5rcywNCkppYWRvbmcNCg0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IEppYWRvbmcNCj4g
Pj4+IHYyOiBvcHRpbWl6ZSBnZXRfZmVuY2Vfc3RhcnRfdGltZS4NCj4gPj4+IFNpZ25lZC1vZmYt
Ynk6IEppYWRvbmcgWmh1IDxKaWFkb25nLlpodUBhbWQuY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiAg
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYyB8IDMxDQo+ID4+ICsr
KysrKysrKysrKysrKysrKysrLS0tDQo+ID4+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfam9iLmggICB8ICAzICsrKw0KPiA+Pj4gICAgMiBmaWxlcyBjaGFuZ2VkLCAzMSBp
bnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYw0KPiA+Pj4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYw0KPiA+Pj4gaW5kZXggMmYyNGE2YWEx
M2JmLi43MmJiMDA3ZTQ4YzggMTAwNjQ0DQo+ID4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZmVuY2UuYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2ZlbmNlLmMNCj4gPj4+IEBAIC04OCw2ICs4OCwzMSBAQCBzdGF0aWMgaW5s
aW5lIHN0cnVjdCBhbWRncHVfZmVuY2UNCj4gPj4gKnRvX2FtZGdwdV9mZW5jZShzdHJ1Y3QgZG1h
X2ZlbmNlICpmKQ0KPiA+Pj4gICAgICByZXR1cm4gTlVMTDsNCj4gPj4+ICAgIH0NCj4gPj4+DQo+
ID4+PiArc3RhdGljIGlubGluZSB2b2lkIHNldF9mZW5jZV9zdGFydF90aW1lKHN0cnVjdCBkbWFf
ZmVuY2UgKmYsDQo+ID4+PiAra3RpbWVfdA0KPiA+Pj4gK3N0YXJ0X3RpbWVzdGFtcCkgew0KPiA+
Pj4gKyAgIGlmIChmLT5vcHMgPT0gJmFtZGdwdV9mZW5jZV9vcHMpIHsNCj4gPj4+ICsgICAgICAg
ICAgIHN0cnVjdCBhbWRncHVfZmVuY2UgKl9fZiA9IGNvbnRhaW5lcl9vZihmLCBzdHJ1Y3QNCj4g
Pj4gYW1kZ3B1X2ZlbmNlLA0KPiA+Pj4gK2Jhc2UpOw0KPiA+Pj4gKw0KPiA+Pj4gKyAgICAgICAg
ICAgX19mLT5zdGFydF90aW1lc3RhbXAgPSBzdGFydF90aW1lc3RhbXA7DQo+ID4+PiArICAgfSBl
bHNlIGlmIChmLT5vcHMgPT0gJmFtZGdwdV9qb2JfZmVuY2Vfb3BzKSB7DQo+ID4+PiArICAgICAg
ICAgICBzdHJ1Y3QgYW1kZ3B1X2pvYiAqam9iID0gY29udGFpbmVyX29mKGYsIHN0cnVjdA0KPiA+
Pj4gK2FtZGdwdV9qb2IsIGh3X2ZlbmNlKTsNCj4gPj4+ICsNCj4gPj4+ICsgICAgICAgICAgIGpv
Yi0+c3RhcnRfdGltZXN0YW1wID0gc3RhcnRfdGltZXN0YW1wOw0KPiA+Pj4gKyAgIH0NCj4gPj4+
ICt9DQo+ID4+PiArDQo+ID4+PiArc3RhdGljIGlubGluZSBrdGltZV90IGdldF9mZW5jZV9zdGFy
dF90aW1lKHN0cnVjdCBkbWFfZmVuY2UgKmYpIHsNCj4gPj4+ICsgICBpZiAodW5saWtlbHkoZi0+
b3BzID09ICZhbWRncHVfZmVuY2Vfb3BzKSkgew0KPiA+Pj4gKyAgICAgICAgICAgc3RydWN0IGFt
ZGdwdV9mZW5jZSAqX19mID0gY29udGFpbmVyX29mKGYsIHN0cnVjdA0KPiA+PiBhbWRncHVfZmVu
Y2UsDQo+ID4+PiArYmFzZSk7DQo+ID4+PiArDQo+ID4+PiArICAgICAgICAgICByZXR1cm4gX19m
LT5zdGFydF90aW1lc3RhbXA7DQo+ID4+PiArICAgfQ0KPiA+Pj4gKyAgIHN0cnVjdCBhbWRncHVf
am9iICpqb2IgPSBjb250YWluZXJfb2YoZiwgc3RydWN0IGFtZGdwdV9qb2IsDQo+ID4+PiAraHdf
ZmVuY2UpOw0KPiA+Pj4gKw0KPiA+Pj4gKyAgIHJldHVybiBqb2ItPnN0YXJ0X3RpbWVzdGFtcDsN
Cj4gPj4+ICt9DQo+ID4+PiArDQo+ID4+PiAgICAvKioNCj4gPj4+ICAgICAqIGFtZGdwdV9mZW5j
ZV93cml0ZSAtIHdyaXRlIGEgZmVuY2UgdmFsdWUNCj4gPj4+ICAgICAqDQo+ID4+PiBAQCAtMTk3
LDcgKzIyMiw3IEBAIGludCBhbWRncHVfZmVuY2VfZW1pdChzdHJ1Y3QgYW1kZ3B1X3JpbmcNCj4g
KnJpbmcsDQo+ID4+IHN0cnVjdCBkbWFfZmVuY2UgKipmLCBzdHJ1Y3QgYW1kDQo+ID4+PiAgICAg
ICAgICAgICAgfQ0KPiA+Pj4gICAgICB9DQo+ID4+Pg0KPiA+Pj4gLSAgIHRvX2FtZGdwdV9mZW5j
ZShmZW5jZSktPnN0YXJ0X3RpbWVzdGFtcCA9IGt0aW1lX2dldCgpOw0KPiA+Pj4gKyAgIHNldF9m
ZW5jZV9zdGFydF90aW1lKGZlbmNlLCBrdGltZV9nZXQoKSk7DQo+ID4+Pg0KPiA+Pj4gICAgICAv
KiBUaGlzIGZ1bmN0aW9uIGNhbid0IGJlIGNhbGxlZCBjb25jdXJyZW50bHkgYW55d2F5LCBvdGhl
cndpc2UNCj4gPj4+ICAgICAgICogZW1pdHRpbmcgdGhlIGZlbmNlIHdvdWxkIG1lc3MgdXAgdGhl
IGhhcmR3YXJlIHJpbmcgYnVmZmVyLg0KPiA+Pj4gQEAgLTQyOCw3ICs0NTMsNyBAQCB1NjQNCj4g
Pj4gYW1kZ3B1X2ZlbmNlX2xhc3RfdW5zaWduYWxlZF90aW1lX3VzKHN0cnVjdCBhbWRncHVfcmlu
ZyAqcmluZykNCj4gPj4+ICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gPj4+DQo+ID4+PiAgICAg
IHJldHVybiBrdGltZV91c19kZWx0YShrdGltZV9nZXQoKSwNCj4gPj4+IC0gICAgICAgICAgIHRv
X2FtZGdwdV9mZW5jZShmZW5jZSktPnN0YXJ0X3RpbWVzdGFtcCk7DQo+ID4+PiArICAgICAgICAg
ICBnZXRfZmVuY2Vfc3RhcnRfdGltZShmZW5jZSkpOw0KPiA+Pj4gICAgfQ0KPiA+Pj4NCj4gPj4+
ICAgIC8qKg0KPiA+Pj4gQEAgLTQ1MSw3ICs0NzYsNyBAQCB2b2lkDQo+ID4+IGFtZGdwdV9mZW5j
ZV91cGRhdGVfc3RhcnRfdGltZXN0YW1wKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywNCj4gPj4g
dWludDMyX3Qgc2VxLA0KPiA+Pj4gICAgICBpZiAoIWZlbmNlKQ0KPiA+Pj4gICAgICAgICAgICAg
IHJldHVybjsNCj4gPj4+DQo+ID4+PiAtICAgdG9fYW1kZ3B1X2ZlbmNlKGZlbmNlKS0+c3RhcnRf
dGltZXN0YW1wID0gdGltZXN0YW1wOw0KPiA+Pj4gKyAgIHNldF9mZW5jZV9zdGFydF90aW1lKGZl
bmNlLCB0aW1lc3RhbXApOw0KPiA+Pj4gICAgfQ0KPiA+Pj4NCj4gPj4+ICAgIC8qKg0KPiA+Pj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2IuaA0KPiA+
Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfam9iLmgNCj4gPj4+IGluZGV4
IGE5NjNhMjVkZGQ2Mi4uM2E3M2ZlMTFhMWNlIDEwMDY0NA0KPiA+Pj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5oDQo+ID4+PiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfam9iLmgNCj4gPj4+IEBAIC03Myw2ICs3Myw5IEBAIHN0cnVj
dCBhbWRncHVfam9iIHsNCj4gPj4+ICAgICAgdWludDY0X3QgICAgICAgICAgICAgICAgZ2RzX3Zh
Ow0KPiA+Pj4gICAgICBib29sICAgICAgICAgICAgICAgICAgICBpbml0X3NoYWRvdzsNCj4gPj4+
DQo+ID4+PiArICAgLyogc3RhcnQgdGltZXN0YW1wIGZvciBod19mZW5jZSovDQo+ID4+PiArICAg
a3RpbWVfdCAgICAgICAgICAgICAgICAgc3RhcnRfdGltZXN0YW1wOw0KPiA+Pj4gKw0KPiA+Pj4g
ICAgICAvKiBqb2JfcnVuX2NvdW50ZXIgPj0gMSBtZWFucyBhIHJlc3VibWl0IGpvYiAqLw0KPiA+
Pj4gICAgICB1aW50MzJfdCAgICAgICAgICAgICAgICBqb2JfcnVuX2NvdW50ZXI7DQo+ID4+Pg0K
DQo=
