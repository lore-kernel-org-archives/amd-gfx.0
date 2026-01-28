Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F5AD2F00C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 00:45:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDF9D10E5D8;
	Wed, 28 Jan 2026 00:45:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KYCUjYSr";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013032.outbound.protection.outlook.com
 [40.93.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D56210E5D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 00:45:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAjrHoI1pfQg+m9CrxLfWAFcUTsv6xDkUhHI0kbfndb1IPvQqEc3j+gmbv7FXG26HZRR8xsP43jkSQqTMotNMfehrqPKPGpQuIdPoJZvUAgj1pTykt4QoweP8uNVbKibqcjH5Z44SSJM3X/w7eymt3G5j+NiIy0jPy/SJIJ6N7DQQFoWdiMpjVDkxM42gbdMfXtBMnZGFzMol1ebXpM4NQetETNtPEU34fhSHa5Q5wnTqtQ9Ad46cDgSxDTEvoP/ePT9QOSbfuYtIjliiTj6z/4ddlRPzHiGiXvIDoErXZ7Bn8pEHLCszSudPRQGKIL7EY09SPI9tlt8DniL7x9V8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSBhQp1UKzN3pTa3djjA0iZdJbMQCvAlM/njMgLm860=;
 b=gULXbm36bqf+79dxw7W8Us13+6oWRGZgghE0oVMQ1UHpMOhbT3gPCFMzQQfVy9sVWSmZLRnOdZMjpT9w6bRIFWGDzgZLSnIgNtiQaoqISeadVNGUZt/rjNS/38r80mkQfTDNUTMILgjSOcc3OpbUOWo88r7oHlguVtQOaCJfZMTjbbIA7sYZ3qD0dIh+rfI7MxT0HOg3Z4YnbGxtAJ7CWgr5Bbv1ZwPr487bbm7bHcshAtA2zQ1w3SHsYq9H7sghaN9P4PHWQ5+AuP2GOWPUNheS1Yofx4Hz7X6ChxPhdheQBMV4qy3xYAWQH3j/lOOIOAO8Sue+XRKVo/WC95o6hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSBhQp1UKzN3pTa3djjA0iZdJbMQCvAlM/njMgLm860=;
 b=KYCUjYSrDNQXx0Hm+i6yzZ1y6D4jp3mhpQJu8I953XE1gAZwoDp7dwLGt+Q7NOkZofwaI+nDHQDXIPX3hUrxhUwRMkfy2F5+pEM9f6suJ23vrmibM2HDOqVWivknwptbAoibvRrwlohh5cHnE3T1NWN/SqgDhC8V4ZZo5pmj7l8=
Received: from MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 by MN2PR12MB4335.namprd12.prod.outlook.com (2603:10b6:208:1d4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 00:45:01 +0000
Received: from MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::cdfc:80cc:2903:19b1]) by MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::cdfc:80cc:2903:19b1%4]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 00:45:01 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Belanger, David" <David.Belanger@amd.com>
Subject: RE: [PATCH 4/4] drm/amdkfd: Use AMDGPU_MQD_SIZE_ALIGN in gfx11+ kfd
 mqd manager
Thread-Topic: [PATCH 4/4] drm/amdkfd: Use AMDGPU_MQD_SIZE_ALIGN in gfx11+ kfd
 mqd manager
Thread-Index: AQHcjq4pADrnHoiPnU+3OzwwVrZHn7VmNP8AgACLYPA=
Date: Wed, 28 Jan 2026 00:45:01 +0000
Message-ID: <MW6PR12MB8898B34E5B7DDB33CFC9995EFB91A@MW6PR12MB8898.namprd12.prod.outlook.com>
References: <20260126102514.273891-1-lang.yu@amd.com>
 <20260126102514.273891-4-lang.yu@amd.com>
 <BL3PR12MB64252E57E572DBBD5387C23DEE90A@BL3PR12MB6425.namprd12.prod.outlook.com>
In-Reply-To: <BL3PR12MB64252E57E572DBBD5387C23DEE90A@BL3PR12MB6425.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-01-28T00:44:52.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB8898:EE_|MN2PR12MB4335:EE_
x-ms-office365-filtering-correlation-id: 0250e701-7f85-4432-ff4c-08de5e067835
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?KaO19HdDcT+aTS9vBntSxqxw5Wcrx+HSNlsJ7KyYAUK2kUCLhXGwWvXv0Ug0?=
 =?us-ascii?Q?KqoSmFLxBZtJcwraUmcKvuVcpE9lLsBu6cExCQGINETAMOd+91aUuQoLTbyh?=
 =?us-ascii?Q?L/oCt49u0NImJxUlIExoD9IfJyFO+3oWIV7cCgU8uvaXi+cmmkT5HkK6GguN?=
 =?us-ascii?Q?v/5KN8EPt4r+9sy203tuxl4IZrSDENwCY5Rwox0KER5tshaqBgdPUrLKnOOg?=
 =?us-ascii?Q?w1jqT42Y8JPuyq1hdqClztlqFRdYa5lFFwns8e2tUVFpGZRCViumkP2iKbax?=
 =?us-ascii?Q?cpppRXqcBxBIsdPOCMz6x6mCDK+seKj2bc4SZiwgNItTu3YzlXG8rKZQqBdj?=
 =?us-ascii?Q?OM8lKHHEYC90IQP850oMtzD2UmgjDLyac8BetWoyt5ezA9C+jqwvMQ4OFXDL?=
 =?us-ascii?Q?fJNUz7kYb6zDyWmR2Usd4QHf/k6sB00GGtA+ebz86Xj875pu6eeiXt4ZLxhg?=
 =?us-ascii?Q?zb6NgqQIbxKjPRYZfEA1BrXPrMcWqzjQbJfjtgMHk3CP3daW4s86yAmtGA0T?=
 =?us-ascii?Q?ywtALVU+8AyKX4AeRSH3MX5u53Y+Q3xXCw0f1AuTk3Hsz1aa0WCiYjabJ8f3?=
 =?us-ascii?Q?yqZHAQAZ2IgfnYty29INnJw/Ixulhy9dpGhtZnhdkgIs7wXOO0ENCaZQAka9?=
 =?us-ascii?Q?r3YNJ5V4zItiQXt37bRQ6hyDcLqmyX+22y1Pfe1NoMFNfPI6tA7eLjCmy/TW?=
 =?us-ascii?Q?s5E3TxIKSejvJmogFmErcKJqGTVKM4OVR/SJYmTpx5nEqezLhWy0HtY3pBpM?=
 =?us-ascii?Q?DVPd92vJMrboTApOps/OlUQyPsQMNn6EO5BwGwIxiVhGurzL6jXcEPpNsihi?=
 =?us-ascii?Q?QjLgH5Nhsqvv7ZiSmhTrFL9GNumt/z3KoeaDnlhqUIsJQYWE6xVIsS54Dgwh?=
 =?us-ascii?Q?dD5XP5sAjTeyZp9+8O8cDyuJsIIuEufEAeVT33xM8RCdjHJRtpsfKsQhHuRr?=
 =?us-ascii?Q?heL1hNYDdiNrJ5aVWg+hgutJ+wpvA931+teHOSzk6fXRLkRYdnr4h0QX8pNZ?=
 =?us-ascii?Q?We4xSfSLWeKLrGSx8qwYOsxXlu3pB2lSGmTWAxk+QqQt3WsvWaKr7mEFTKNG?=
 =?us-ascii?Q?LCFi+q+mOPO4h/WrZDOuUFMAZRpvCTcf0cOuCKSjdKeCNuDPZeLd/A6P7P8d?=
 =?us-ascii?Q?rT13CfgGyQ+agLL6zwy2t3gtULleaIpGQz/ovSa7PY7zYo0IqR468Tou3Qd6?=
 =?us-ascii?Q?AOyMRsh+cbv7Ss1X8T3dWcN0oonk+n8GhJyghObvYONfEuyT+zyBcTLZKsw8?=
 =?us-ascii?Q?9tj+idF3Oqcdu4o+FWHcv9SAaV1AFrElPskZbGaNVC03hbS63WvnmIvZMMde?=
 =?us-ascii?Q?m60A+7UqddtkE7H9VLwTBRnaTFlsN47ZQ4zgiw6hw9u30Mc+kkUhUYc24zJ8?=
 =?us-ascii?Q?v3lOcY70lXLXv3n3uDRAh1Xy6yCKTiyob56q8tx5RqqVn/SQFtslzX4naYoV?=
 =?us-ascii?Q?mmPWBIall7RlCH7MdItVy1gygs+pNtt3wGbm+GJ+baiuCUP545PWeU82eqDp?=
 =?us-ascii?Q?WZofVTQaOYtrRtH04iXRk+XbUZHm8NBdR+XFe9ctPC5N3axN4ZKtZGaV2eHx?=
 =?us-ascii?Q?NyKMlAWdNsFoYDYTjjouixKJ69bLQ3uhK9umFc9+EB8QvkELJ7zGiPGKGXPM?=
 =?us-ascii?Q?tWQdjg/B6akmpVvDnztpu7I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c/ko/J2QZwJ10q8zcxfWicVleI7LYOqAhefYhP37N8CbdXbPv9REUPHw5xqJ?=
 =?us-ascii?Q?3OIaRdeCp+OokyU2JuN4grSL9Iww0+B2z4zgLZMmRYi4/MclKE90c1ispO9k?=
 =?us-ascii?Q?kZbjIXzQcHwVT+Msij2a6h0Vg5E6B3h+UNA/oWryyG8LLRnoi+ICwqYSpwLO?=
 =?us-ascii?Q?aDT64E6N8sZqN1JWhj6M6KLNqe/MS+/F9Vv+rlJ0wKNBnTpOwmFc3J7m7cu8?=
 =?us-ascii?Q?YFYCMeetGa/6zNgYwV4T2K8JxpULZXFYMqurGdgmFHqU1NpKcY2UR0/IFJEf?=
 =?us-ascii?Q?XjXwwa0IeRbjnD3fT8k+pwyDfdhbeSopauZTtJSNcU8IeAoBq7IsNqqjAlrL?=
 =?us-ascii?Q?RgpnOl6oh03Diu6rVFHCpWoUl62ZuJeGrmuiVrbAzu38sQ0h0sAQsz+uNmjG?=
 =?us-ascii?Q?CYGlbQ2sHvJxFj9tiasFDoOwMSkADU34hg/uwgPyihYaIXwChu2YsrM40V4w?=
 =?us-ascii?Q?E1ml3SZ/FwS/5oVtuqCKFRF5epI2/Gpd2kXdgEhaRcNDZqA2WPce+f/wAdWZ?=
 =?us-ascii?Q?lXG1nVBgC38epeS2HMWdUw5PEKjcYhVH3dzO5hnDSc6Kh8XAF7TbA3JKBFum?=
 =?us-ascii?Q?XLdKA/fBZ3MWVHdQKmc9zlgmXTSE37490psntDAXc5cv/O+9ptMCF9UyhBlV?=
 =?us-ascii?Q?FHXGgBwZzV/Ra/Xa10Q7Mg0Figbxb192xO7Mg3tTh9SBmBpnVa1keRoBxZOz?=
 =?us-ascii?Q?ZC7yoyiNvx92JBqzEqS2iY7ar07UXnaskeShR3zTBecCzDyktkOQQGG/EHEL?=
 =?us-ascii?Q?uXYPwt9t3Eu3ODihgMpHx4XzvLvItXcxlFn/Y11OVwqDB3e9R4dpxaxXcLaN?=
 =?us-ascii?Q?eYdFikbQY7ieb3VnnCtlQ5az1QT7pH07DqmSJ0ht5yBGcLNydnD8bJ1Z1fzH?=
 =?us-ascii?Q?McJuYdm5OdJflIsLLp7dsFa9ZDwR2QyWgR55hK/0DLhweOmxeSLTJtoyOyNl?=
 =?us-ascii?Q?yG4rfGHV+PQ1+EVKTSmV1Tp/2HGL1J+tEgRpmShhNz85Z+BC7lg8zbVSxjaL?=
 =?us-ascii?Q?168wy2UfxLyznl1X9yse+ojhc6uY4rCp2jG974FNiHDwbzpdiUR4PBkUGnQ3?=
 =?us-ascii?Q?Wou4V1cG/NdqL/vhYCAQ/wA1AFJJk4KRHS0iSc+8MdCWFXJQC+QtIXLH2zqX?=
 =?us-ascii?Q?pMv+B8LaBAv0OL2YUAmZYEVgkE93W6YI7zwtqaFb1XrxUrL8hhLj7sM5XYqn?=
 =?us-ascii?Q?lrF4xBuy8bNSKDhtpn8gl2oUTjrxW25hIZ9PZLy1VP6SuE1uHAGhdD5jq3uR?=
 =?us-ascii?Q?7j61A1gzgu/84BAklmXT+sOZ+9ff97Yj+S6PbyIKCkVqWBVBYeGJv5isiXZT?=
 =?us-ascii?Q?wMJRfHbbovUgff38jTHOPHd4gp2kiFR0JbkR48ffOQeBhwDZhW+JLtBZgcbd?=
 =?us-ascii?Q?otC17AyXik2xM5d1dfps6QzmCeZhV/hNNeDlE67Y/OaLnkOcDrS/luVB+fCI?=
 =?us-ascii?Q?odbeeQvIfoMFjoEg2syPVAqiOV75/zsw3FZcUS81yQFknu8J6l68cOJBfJ5d?=
 =?us-ascii?Q?dBCfcbPSmgjhANY10bimsbzfq/KZF3oooPfd2g4iQZpRoEd+awDAZqUAB9FL?=
 =?us-ascii?Q?8uiDLKWgAjFFvDOaSnBGqlngdRWU39HKlrR8vlohkZ2TyJUgoVLihTSN5+3c?=
 =?us-ascii?Q?InGE3FDG+MOVOlZyKD2EjYeP8HL7UCHiZtVkyKHlaHyf++Id0t8QJ9s5jzYj?=
 =?us-ascii?Q?VLWY6VyJshoLcSvnc/TiRYwy5OZJzL5Y77+f275yqosZ4EJL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0250e701-7f85-4432-ff4c-08de5e067835
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 00:45:01.2360 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F/qzSv3GC8A6N7S78zt207d/DnBK8Ivkedl8wdgqZeoFMqEwMvVK2QusPQnYtCnAAf3C6b0kDJthub/d1Vm1Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4335
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

[Public]

>-----Original Message-----
>From: Joshi, Mukul <Mukul.Joshi@amd.com>
>Sent: Wednesday, January 28, 2026 12:23 AM
>To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
><Alexander.Deucher@amd.com>; Belanger, David <David.Belanger@amd.com>
>Subject: RE: [PATCH 4/4] drm/amdkfd: Use AMDGPU_MQD_SIZE_ALIGN in gfx11+
>kfd mqd manager
>
>[AMD Official Use Only - AMD Internal Distribution Only]
>
>> -----Original Message-----
>> From: Yu, Lang <Lang.Yu@amd.com>
>> Sent: Monday, January 26, 2026 5:25 AM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>;
>> Belanger, David <David.Belanger@amd.com>; Yu, Lang <Lang.Yu@amd.com>
>> Subject: [PATCH 4/4] drm/amdkfd: Use AMDGPU_MQD_SIZE_ALIGN in gfx11+
>> kfd mqd manager
>>
>> MES is enabled by default from gfx11+.
>>
>> Signed-off-by: Lang Yu <lang.yu@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  3 ++
>> .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  | 22 +++-----------
>> .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c  | 10 +++----
>>  .../drm/amd/amdkfd/kfd_mqd_manager_v12_1.c    | 29 ++++---------------
>>  4 files changed, 17 insertions(+), 47 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
>> index ceb6566ff3e1..d88d0de58edd 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
>> @@ -292,6 +292,9 @@ void kfd_get_hiq_xcc_mqd(struct kfd_node *dev,
>> struct kfd_mem_obj *mqd_mem_obj,  uint64_t kfd_mqd_stride(struct
>> mqd_manager *mm,
>>                       struct queue_properties *q)  {
>> +     if (KFD_GC_VERSION(mm->dev) >=3D IP_VERSION(11, 0, 0))
>> +             return AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
>> +
>>       return mm->mqd_size;
>>  }
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
>> index 5c44d0987737..7e5a7ab6d0c0 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
>> @@ -102,20 +102,11 @@ static void set_priority(struct v11_compute_mqd
>> *m, struct queue_properties *q)  static struct kfd_mem_obj
>> *allocate_mqd(struct mqd_manager *mm,
>>               struct queue_properties *q)  {
>> +     u32 mqd_size =3D AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
>>       struct kfd_node *node =3D mm->dev;
>>       struct kfd_mem_obj *mqd_mem_obj;
>> -     int size;
>> -
>> -     /*
>> -      * MES write to areas beyond MQD size. So allocate
>> -      * 1 PAGE_SIZE memory for MQD is MES is enabled.
>> -      */
>> -     if (node->kfd->shared_resources.enable_mes)
>> -             size =3D PAGE_SIZE;
>> -     else
>> -             size =3D sizeof(struct v11_compute_mqd);
>>
>> -     if (kfd_gtt_sa_allocate(node, size, &mqd_mem_obj))
>> +     if (kfd_gtt_sa_allocate(node, mqd_size, &mqd_mem_obj))
>>               return NULL;
>>
>>       return mqd_mem_obj;
>> @@ -127,18 +118,13 @@ static void init_mqd(struct mqd_manager *mm,
>> void **mqd,  {
>>       uint64_t addr;
>>       struct v11_compute_mqd *m;
>> -     int size;
>> +     u32 mqd_size =3D AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
>>       uint32_t wa_mask =3D q->is_dbg_wa ? 0xffff : 0xffffffff;
>>
>>       m =3D (struct v11_compute_mqd *) mqd_mem_obj->cpu_ptr;
>>       addr =3D mqd_mem_obj->gpu_addr;
>>
>> -     if (mm->dev->kfd->shared_resources.enable_mes)
>> -             size =3D PAGE_SIZE;
>> -     else
>> -             size =3D sizeof(struct v11_compute_mqd);
>> -
>> -     memset(m, 0, size);
>> +     memset(m, 0, mqd_size);
>>
>>       m->header =3D 0xC0310800;
>>       m->compute_pipelinestat_enable =3D 1; diff --git
>> a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
>> index b7ac2dea8775..a51f217329db 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
>> @@ -83,14 +83,11 @@ static void set_priority(struct v12_compute_mqd
>> *m, struct queue_properties *q)  static struct kfd_mem_obj
>> *allocate_mqd(struct mqd_manager *mm,
>>               struct queue_properties *q)  {
>> +     u32 mqd_size =3D AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
>>       struct kfd_node *node =3D mm->dev;
>>       struct kfd_mem_obj *mqd_mem_obj;
>>
>> -     /*
>> -      * Allocate one PAGE_SIZE memory for MQD as MES writes to areas
>> beyond
>> -      * struct MQD size.
>> -      */
>> -     if (kfd_gtt_sa_allocate(node, PAGE_SIZE, &mqd_mem_obj))
>> +     if (kfd_gtt_sa_allocate(node, mqd_size, &mqd_mem_obj))
>>               return NULL;
>>
>>       return mqd_mem_obj;
>> @@ -102,11 +99,12 @@ static void init_mqd(struct mqd_manager *mm, void
>> **mqd,  {
>>       uint64_t addr;
>>       struct v12_compute_mqd *m;
>> +     u32 mqd_size =3D AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
>>
>>       m =3D (struct v12_compute_mqd *) mqd_mem_obj->cpu_ptr;
>>       addr =3D mqd_mem_obj->gpu_addr;
>>
>> -     memset(m, 0, PAGE_SIZE);
>> +     memset(m, 0, mqd_size);
>>
>>       m->header =3D 0xC0310800;
>>       m->compute_pipelinestat_enable =3D 1; diff --git
>> a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
>> index 0b0d802a0917..d0776ba2cc99 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
>> @@ -32,17 +32,6 @@
>>  #include "amdgpu_amdkfd.h"
>>  #include "kfd_device_queue_manager.h"
>>
>> -#define MQD_SIZE     (2 * PAGE_SIZE)
>> -
>> -static uint64_t mqd_stride_v12_1(struct mqd_manager *mm,
>> -                             struct queue_properties *q)
>> -{
>> -     if (q->type =3D=3D KFD_QUEUE_TYPE_COMPUTE)
>> -             return MQD_SIZE;
>> -     else
>> -             return PAGE_SIZE;
>> -}
>> -
>>  static inline struct v12_1_compute_mqd *get_mqd(void *mqd)  {
>>       return (struct v12_1_compute_mqd *)mqd; @@ -148,21 +137,14 @@
>> static void set_priority(struct v12_1_compute_mqd *m, struct
>> queue_properties *q  static struct kfd_mem_obj *allocate_mqd(struct
>> mqd_manager *mm,
>>               struct queue_properties *q)  {
>> +     u32 mqd_size =3D AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
>>       struct kfd_node *node =3D mm->dev;
>>       struct kfd_mem_obj *mqd_mem_obj;
>> -     unsigned int size;
>>
>> -     /*
>> -      * Allocate two PAGE_SIZE memory for Compute MQD as MES writes
>> to areas beyond
>> -      * struct MQD size. Size of the Compute MQD is 1 PAGE_SIZE.
>> -      * For SDMA MQD, we allocate 1 Page_size.
>> -      */
>>       if (q->type =3D=3D KFD_QUEUE_TYPE_COMPUTE)
>> -             size =3D MQD_SIZE * NUM_XCC(node->xcc_mask);
>> -     else
>> -             size =3D PAGE_SIZE;
>> +             mqd_size *=3D NUM_XCC(node->xcc_mask);
>>
>
>SDMA MQD allocation is not per XCC in the partition. This wastes a ton of =
memory for
>SDMA queues.

Look carefully. " if (q->type =3D=3D KFD_QUEUE_TYPE_COMPUTE)" is still ther=
e.
Only compute queue will be applied.

Regards,
Lang


>Regards,
>Mukul
>
>> -     if (kfd_gtt_sa_allocate(node, size, &mqd_mem_obj))
>> +     if (kfd_gtt_sa_allocate(node, mqd_size, &mqd_mem_obj))
>>               return NULL;
>>
>>       return mqd_mem_obj;
>> @@ -174,11 +156,12 @@ static void init_mqd(struct mqd_manager *mm,
>> void **mqd,  {
>>       uint64_t addr;
>>       struct v12_1_compute_mqd *m;
>> +     u32 mqd_size =3D AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
>>
>>       m =3D (struct v12_1_compute_mqd *) mqd_mem_obj->cpu_ptr;
>>       addr =3D mqd_mem_obj->gpu_addr;
>>
>> -     memset(m, 0, MQD_SIZE);
>> +     memset(m, 0, mqd_size);
>>
>>       m->header =3D 0xC0310800;
>>       m->compute_pipelinestat_enable =3D 1; @@ -681,7 +664,7 @@ struct
>> mqd_manager *mqd_manager_init_v12_1(enum KFD_MQD_TYPE type,
>>               mqd->is_occupied =3D kfd_is_occupied_cp;
>>               mqd->mqd_size =3D sizeof(struct v12_1_compute_mqd);
>>               mqd->get_wave_state =3D get_wave_state_v12_1;
>> -             mqd->mqd_stride =3D mqd_stride_v12_1;
>> +             mqd->mqd_stride =3D kfd_mqd_stride;
>>  #if defined(CONFIG_DEBUG_FS)
>>               mqd->debugfs_show_mqd =3D debugfs_show_mqd;  #endif
>> --
>> 2.34.1
>

