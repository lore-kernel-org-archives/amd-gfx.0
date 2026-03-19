Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9EF41075275
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 08:14:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88BD110E484;
	Thu, 19 Mar 2026 08:14:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e+v1Hqsg";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010045.outbound.protection.outlook.com [52.101.201.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1B2D10E484
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 08:14:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXRmWL23Oorfu9xfk+07ZmAOWAk0ZzXDDk1j0XEhQz9Ci9iXVjnuJwI7++/vjcqQYhDCL8Zo2jRk2nRI+ssSW5N+c6wBhMGUqzsYiZSMs6ovKZzem99oBo83/Sf27h565dnoHF6+S+Frq3t+8Kk/lOG72tdldGwxFBKiTWG2Gwxd7xlUHAOOuRUTzSHsBaTM+WVQCixLR7d3jDeU8nszU/Ed/UpFRyQfVjCT600x+8qSJ87abAnlf5Dnjgy6Qvdqitb0aJ0C3KrZtkdz0Laa4sIK2JIW82B5ITwjaR1c5EmNhOg2iSv4dPLGFpx8lO2jnsmq5209pboWeEOX1cQqLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fe5GS0BOEuca241Ktdlue2hCeQLMvrZujBIDtNBcgc=;
 b=Tj3eAZ7EKc+Xj1MG60o846wisin5uvZVS6osdZW724n0NaWdAPheV2XrJYRgRnfWSo6uZwb9sbfL1nFMbzLfm3lSnWwZH2FkXJLHgs8RTmi+FegjqeZazewHQI+UcSmqqIuIBni8P+qB2jkDBgIbXKxJFM5fgOEEABrnCQg8iD9ceO9eeXe8A2SCTQIzw5j0XkOqqFtXj8/jYOuuO2XswXRETxWMdiYj1aZ1sNLPIVBtX8hNTz8DkhPbECvZFl/YY4wPFnG/vS7/SzGcfXyGHk1yXpgOeZWWhPnATUWjQiZFEQ1Ag63RQUh9K0eb62ox/igpbe6vVi4tDQNXjU1w3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fe5GS0BOEuca241Ktdlue2hCeQLMvrZujBIDtNBcgc=;
 b=e+v1Hqsg1umDoUfJYYpak/ebphMBOR0+25EPg7NR7KlT6bVnnrgyCrNHbG+mJ9LNWj4IRM9pPzAuLFjMMRsmjw7nU1ZnaCllaB0W9LacCTYXV7p4XReFGGI6ZNeg3Z+81Xq59QmKLOk8UMpS1J0B4CpovK5kWfgaZUhUMpIxmHU=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 CH1PPF5EBD457EF.namprd12.prod.outlook.com (2603:10b6:61f:fc00::610)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Thu, 19 Mar
 2026 08:14:40 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.20.9700.006; Thu, 19 Mar 2026
 08:14:40 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH 1/3] drm/amd/pm: add variant func smu_cmn_send_msg() to
 unify msg sending logic
Thread-Topic: [PATCH 1/3] drm/amd/pm: add variant func smu_cmn_send_msg() to
 unify msg sending logic
Thread-Index: AQHct0VzirRXPXvRu0CtVZo/CbX0SrW1NymAgAAhNvCAACJ0AIAABABg
Date: Thu, 19 Mar 2026 08:14:40 +0000
Message-ID: <DM6PR12MB297226DA71F3FADC5F4C1E6B824FA@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260319020910.2620721-1-kevinyang.wang@amd.com>
 <a5044ebf-d4e3-4363-a211-9b6144c37c29@amd.com>
 <DM6PR12MB2972BD4381815DDFD4C650A0824FA@DM6PR12MB2972.namprd12.prod.outlook.com>
 <SJ0PR12MB70821C13DE8260DE5CBABA48974FA@SJ0PR12MB7082.namprd12.prod.outlook.com>
In-Reply-To: <SJ0PR12MB70821C13DE8260DE5CBABA48974FA@SJ0PR12MB7082.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-19T07:40:07.1669361Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|CH1PPF5EBD457EF:EE_
x-ms-office365-filtering-correlation-id: c7a973eb-f973-4e8d-3d1f-08de858f91a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|7053199007|18002099003|22082099003|56012099003|8096899003;
x-microsoft-antispam-message-info: FM79mzUETl3MKJ1JGOTfZpuGbdrg4ra7vxHiOs8IUHWzcFW0sE4LuTEXAs9fg9633EScqzX9Lx3a3rnADnOZK19YkK4YtsD96asNlVi6lL6EIK256vLsdbzYXbbSmHhjdy2YXhtGW8oqLZh6wLT8GYq3gpuJmMdwkW7IiLjPxCyLzS4X02y3+oNvAAa+zMAgQxIrKQSkKN5hdk7AJX9MLIM4Rc1IBGo5P2x3WdKlps7TgV5/7h8WG8g13kdWQEw9MjjUWd96L+YxlG4fb+a3GDoL/Lw1/SLxgNu49nrnexzwQOT4VENILcBVbzDVweVXS/s0k6cklhVFMtwprJACDDr0znZrQca3SPPklTCYUmeD06L771tHP9qWB6ZoI04uo4RFpmoa4AgGoi3RqUldR+68ea2BRhMbdWeOmKmw/5jmqHlbkBJcLFmrQ67YYMZ76EWtqrlN/1ZfauZon+rdNEmpPIY/D46qis9gPNe1VKMjU9kaSF8L0Pm2Uj+JBBFGKvlTJ1wUCzYcTMr6Zuhn7aJnhCTr6HRhr7frZ17iAA30gJeQEJG09BwkZa+FG1BAzhDerBA6vDsfi4Ust3oRFPnU21TyjcljRJjx1I8OAOf0HDprx7VWsD/4Odry2kzVaLHOLW9sOnJeRa8aW21HF15F2vPUEIkpAsrguH3FhmIuy8JnnTH7PY04ZDk7TIb6OcsgyWXeyArECgURR2XBC5ctXNzKZt2YveoNBe8gmDXw2MFKHEkrPiIYuKYXuoD8sNepcE9EjLjO5Fy/xQuwW+SDuyEJtUjGQ/+UcPMdJrE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007)(18002099003)(22082099003)(56012099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Kxo/iHZ2puJscJTzNqOmHi3Xnpye2kMps9wyCrIPUuDZ0hnIYnSXWlfYC9DX?=
 =?us-ascii?Q?Hph3hNS3t3oefFT0XJ9x1fsNVw6NfVVzaQJerX+YmBduc4sRd5sVsZo+eHgP?=
 =?us-ascii?Q?PLfw3PqZEuE2bdEHxUM+uVdN1CvJem55EVLlfOVE13grKeeHXxvcmypeAy/F?=
 =?us-ascii?Q?rgeK7crp7d/p7GZLZzVojyUey9Sx3KNrfMRvtMKKYBY5sVJDvLPLcJkLkXMf?=
 =?us-ascii?Q?8wFl+gWOtUqbcZmgZlU+EKk49jmBKKCWqpmiNB/bPEA718FJEhE875VspTsF?=
 =?us-ascii?Q?RDWsMMsmYLvAYLw5Uwe+PCKpBSCx6CaLpuosKSh7UEx5G99ia6iw9XCl2PWk?=
 =?us-ascii?Q?hndNWY8K4LmiBf4JpeSp2kQLoBfNCFQ4dwjaosjkxH30a3RInSq0yAUmzGRr?=
 =?us-ascii?Q?X0SYjYaPLo2CQ1a5Z3rX98esR4PHKmnAkemeMyxerT4l80fkVr8lp3+y53zC?=
 =?us-ascii?Q?a3zpBUB93KOOQ3PhwGsQ+SfSP/DruDVKEhBTqGwDIZaEgjkueuB4n0VqlumQ?=
 =?us-ascii?Q?zu8RFh4JZMvXp4fkv7PxWgRblR8KRDm8+iYpVSzr8Q7x//vkIBRYnQufpO3B?=
 =?us-ascii?Q?kSf2Melb+0BmCLeiTKpNzZH4JQoCY9KWoYm1AL53ACgtU7tWkHeVkn5O4x2W?=
 =?us-ascii?Q?KxAODlMGe1SyR0wz5jKhFCUQzoS0H1EW8cSqQq7fz6++60PxTqkqz6R19V3J?=
 =?us-ascii?Q?a1PAraUDjM27l0C+tZxykHfA9UMCLk9ijNlM7kRqPHFEGTSTm62NO7Pi6mkp?=
 =?us-ascii?Q?GTsAuo9YUpohxtOain+aFdyKddjEl7pqr8INDKiuwPK1io90mO6/9L0oJD+l?=
 =?us-ascii?Q?6n8gPXq74tseuxUPTj+LDDVMXi6SvFQXJaTyFmCV9OYD/doUvA70boKEdk5k?=
 =?us-ascii?Q?XNYL+G0oJRfG1sbTxMxsQVPn+JvcYKzZCBehzffHbdPdyT8qrEKP+wwITl8B?=
 =?us-ascii?Q?cdyQkj2hEfXmtEevA3ETB6gKl3m/N1WoNCzUeXPGhxrX3uf+fGVbOmKpvu/T?=
 =?us-ascii?Q?WHqrE0jpGyQgb85CUgMVLaboyzMjRxdvBId/8GHsMVCgIy2jWTs/zLA5uzHu?=
 =?us-ascii?Q?xETunH3vitY0wC9ATNtk0pqhFRghH40h5qQAa5sgJSihPMd2RZkmBBBIbEOU?=
 =?us-ascii?Q?SzMlRKFStqCJarUAcZoTOMF7443mBlfQL3iYBi1kadQsVJtqouMOW1Twod48?=
 =?us-ascii?Q?Sr+qlVgDPnYHqBFQSiKBHOGOnIaX6XFPNFko1aLTo7OWvIIs1xLRXSLO2062?=
 =?us-ascii?Q?o+EP64LMK8DEwM8S1iRpkg/Y3xbRfiGL9Sv/68g0aPzNVD526xXvdUNF8Dpi?=
 =?us-ascii?Q?qjfzM3npz7XZVN4GLyEkzj3eZPs0Kln2+QqCxCtBrr40yydhSTz3urzSt5Lv?=
 =?us-ascii?Q?6f1KzVjFVPv5+xWi89oAT7C60QfsfOgPUbzopYxGS8bOjSMmMp6rlmDcFVhC?=
 =?us-ascii?Q?hRPky9R/Vx5vTSRcYcYqOHkOYQMReK5NFjVU9m8usUDmzh60XVI8bUAMsJlh?=
 =?us-ascii?Q?tcvnZLnhUoyK1TK+e4ifqE6LysBLF+wWMCw56LYAHC6ryWR2NsnQtqYjqnsH?=
 =?us-ascii?Q?ojPCqMWYw+fY5qyvAM6rIHt8VxfeDmv5/cUZCRqQ3XoFB6tz86uvXeKUoYyI?=
 =?us-ascii?Q?TZNpDtrXINiw26gJb7Fyk5ixKGL9/6+IO5I0vbCBqDyJvNv8uUBQE4dL0/ik?=
 =?us-ascii?Q?7PenrHAidBWkkAWTH1c4uI+Vl5l9JwJ+GDyxdFfl/tpTeCU1?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB297226DA71F3FADC5F4C1E6B824FADM6PR12MB2972namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a973eb-f973-4e8d-3d1f-08de858f91a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 08:14:40.2856 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JzGmEEt83ftWCLGkfcNAMbyMgC9cj9VBqJfGzOkbgiApNS3soVx2gCeUQxbmS5Y+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF5EBD457EF
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

--_000_DM6PR12MB297226DA71F3FADC5F4C1E6B824FADM6PR12MB2972namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

whether to support the 'timeout' parameter can be decided later based on ac=
tual needs.
at this stage, no known code or scenarios that requires its use.
the parameter of 'timeout' is usually for corner cases and special situatio=
ns,
which are not suitable for the 'cmn' helper, for these cases, using the low=
-level API directly is better.

Best Regards,
Kevin
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, March 19, 2026 3:48 PM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: Re: [PATCH 1/3] drm/amd/pm: add variant func smu_cmn_send_msg() to=
 unify msg sending logic


[Public]

The variadic wrapper assigns different argument meanings based on number of=
 parameters used and the position. It will be hard to read code based on it=
. There is an optional timeout parameter which will need a 5-argument funct=
ion. Just don't want to miss out on that if everyone starts focusing only o=
n cmn helper functions.

Thanks,
Lijo
________________________________
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com<mailto:KevinYang.Wang@amd.c=
om>>
Sent: Thursday, March 19, 2026 11:23:06 AM
To: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>; amd-gfx@li=
sts.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.fr=
eedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>; Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.c=
om>>; Feng, Kenneth <Kenneth.Feng@amd.com<mailto:Kenneth.Feng@amd.com>>
Subject: RE: [PATCH 1/3] drm/amd/pm: add variant func smu_cmn_send_msg() to=
 unify msg sending logic

[AMD Official Use Only - AMD Internal Distribution Only]

This patch simplifies the development flow with a unified interface and red=
uces overhead for developers.
Most developers can implement features without focusing on low-level detail=
s, while complex message sending scenarios can still use the low-level msg =
sending APIs directly.

Btw,
The scattered APIs hurt maintainability, and most developers should focus o=
n business logic rather than low-level details.
Thus, the "cmn" helper is necessary, it only simplifies the common path whi=
le keeping full flexibility for advanced use cases.
We do not have to choose one or the other exclusively.

Best Regards,
Kevin
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
Sent: Thursday, March 19, 2026 11:46 AM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com<mailto:KevinYang.Wang@amd.com=
>>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>; Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.c=
om>>; Feng, Kenneth <Kenneth.Feng@amd.com<mailto:Kenneth.Feng@amd.com>>
Subject: Re: [PATCH 1/3] drm/amd/pm: add variant func smu_cmn_send_msg() to=
 unify msg sending logic



On 19-Mar-26 7:39 AM, Yang Wang wrote:
> add variant func smu_cmn_send_msg() to unify smu message sending
> logic, and enabling support for newer ASIC interfaces such as SMU v15 and=
 upcoming devices.
> (support multi-param/multi-response, standardize code across all smu
> code layers)
>
> The smu_cmn_send_msg() API will expand to the following prototypes based =
on the number of input parameters.
> e.g:
> 1. r =3D smu_cmn_send_msg(smu, msg_id);
> 2. r =3D smu_cmn_send_msg(smu, msg_id, &read_arg); 3. r =3D
> smu_cmn_send_msg(smu, msg_id, param, &read_arg); 4. r =3D
> smu_cmn_send_msg(smu, msg_id,
>                       num_param, [param0, param1, ...],
>                       num_response, [arg0, arg1, ...]
>

The intent behind message control is to make the message protocol transpare=
nt to IP versions and specific IP versions to have more control over them -=
 if they need to override a message mechanisms, add specific timeouts to pa=
rticular messages etc. Overall, they are expected to move away from using '=
cmn' and directly use message control operations. That also avoids redundan=
t memory copies of in/out arguments.

Thanks,
Lijo

> Signed-off-by: Yang Wang <kevinyang.wang@amd.com<mailto:kevinyang.wang@am=
d.com>>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 79 ++++++++++++++++++++++++++
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h | 22 +++++++
>   2 files changed, 101 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index a644579903f4..bc2ac5ae6a48 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -193,6 +193,85 @@ int smu_cmn_send_smc_msg(struct smu_context *smu,
>                                              read_arg);
>   }
>
> +static inline int smu_cmn_send_msg_internal(struct smu_context *smu, enu=
m smu_message_type msg,
> +                                         int num_in_args, u32 *in_args,
> +                                         int num_out_args, u32 *out_args=
) {
> +     struct smu_msg_ctl *ctl =3D &smu->msg_ctl;
> +     struct smu_msg_args args =3D { 0 };
> +     int ret;
> +
> +     if (msg >=3D SMU_MSG_MAX_COUNT)
> +             return -EINVAL;
> +
> +     if ((num_in_args >=3D ARRAY_SIZE(args.args) || num_in_args < 0) ||
> +         (num_out_args >=3D ARRAY_SIZE(args.out_args) || num_out_args < =
0))
> +             return -EINVAL;
> +
> +     if ((num_in_args > 0 && !in_args) || (num_out_args > 0 && !out_args=
))
> +             return -EINVAL;
> +
> +     if (!ctl->ops || !ctl->ops->send_msg)
> +             return -EOPNOTSUPP;
> +
> +     args.msg =3D msg;
> +     args.num_args =3D num_in_args;
> +     args.num_out_args =3D num_out_args;
> +     args.flags =3D 0;
> +     args.timeout =3D 0;
> +
> +     if (num_in_args)
> +             memcpy(&args.args[0], in_args, num_in_args * sizeof(u32));
> +
> +     ret =3D ctl->ops->send_msg(ctl, &args);
> +     if (ret)
> +             return ret;
> +
> +     if (num_out_args)
> +             memcpy(out_args, &args.out_args[0], num_out_args * sizeof(u=
32));
> +
> +     return ret;
> +}
> +
> +/*
> + * NOTE: To ensure compatibility with the behavioral logic of the
> +legacy API,
> + * it is required to explicitly set the parameter "param" to 0 when
> +invoking
> + * the msg_0 and msg_1 functions.
> + * */
> +
> +int __smu_cmn_send_msg_0(struct smu_context *smu, enum
> +smu_message_type msg) {
> +     return __smu_cmn_send_msg_2(smu, msg, 0, NULL); }
> +
> +int __smu_cmn_send_msg_1(struct smu_context *smu, enum smu_message_type =
msg,
> +                      u32 *read_arg)
> +{
> +     return __smu_cmn_send_msg_2(smu, msg, 0, read_arg); }
> +
> +int __smu_cmn_send_msg_2(struct smu_context *smu, enum smu_message_type =
msg,
> +                      u32 param, u32 *read_arg)
> +{
> +     int ret;
> +
> +     if (read_arg)
> +             ret =3D smu_cmn_send_msg_internal(smu, msg, 1, &param, 1, r=
ead_arg);
> +     else
> +             ret =3D smu_cmn_send_msg_internal(smu, msg, 1, &param, 0, N=
ULL);
> +
> +     return ret;
> +}
> +
> +int __smu_cmn_send_msg_4(struct smu_context *smu, enum smu_message_type =
msg,
> +                      int num_in_args, u32 *in_args,
> +                      int num_out_args, u32 *out_args)
> +{
> +     return smu_cmn_send_msg_internal(smu, msg,
> +                                      num_in_args, in_args,
> +                                      num_out_args, out_args);
> +}
> +
>   int smu_cmn_send_debug_smc_msg(struct smu_context *smu,
>                        uint32_t msg)
>   {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> index e4d282d8bcae..f48356c22dbb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> @@ -209,6 +209,28 @@ int smu_cmn_dpm_pcie_gen_idx(int gen);
>   int smu_cmn_dpm_pcie_width_idx(int width);
>   int smu_cmn_check_fw_version(struct smu_context *smu);
>
> +int __smu_cmn_send_msg_0(struct smu_context *smu, enum
> +smu_message_type msg); int __smu_cmn_send_msg_1(struct smu_context *smu,=
 enum smu_message_type msg,
> +                      u32 *read_arg);
> +int __smu_cmn_send_msg_2(struct smu_context *smu, enum smu_message_type =
msg,
> +                      u32 param, u32 *read_arg);
> +int __smu_cmn_send_msg_4(struct smu_context *smu, enum smu_message_type =
msg,
> +                      int num_in_args, u32 *in_args,
> +                      int num_out_args, u32 *out_args);
> +
> +/*
> +* The smu_cmn_send_msg() API will expand to the following prototypes bas=
ed on the number of input parameters.
> +* e.g:
> +* 1. r =3D smu_cmn_send_msg(smu, msg_id);
> +* 2. r =3D smu_cmn_send_msg(smu, msg_id, &read_arg);
> +* 3. r =3D smu_cmn_send_msg(smu, msg_id, param, &read_arg);
> +* 4. r =3D smu_cmn_send_msg(smu, msg_id,
> +*                      num_param, [param0, param1, ...],
> +*                      num_response, [arg0, arg1, ...]
> +*/
> +#define smu_cmn_send_msg(smu, msg, ...) \
> +     CONCATENATE(__smu_cmn_send_msg_, COUNT_ARGS(__VA_ARGS__))(smu, msg,
> +##__VA_ARGS__)
> +
>   /*SMU gpu metrics */
>
>   /* Attribute ID mapping */

--_000_DM6PR12MB297226DA71F3FADC5F4C1E6B824FADM6PR12MB2972namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><!--[if gte mso 9]><xml>
<w:WordDocument>
<w:DontUseAdvancedTypographyReadingMail/>
<w:DontUseJustificationAdvancedTypographyReadingMail/>
<w:DontUseHyphenationAdvancedTypographyReadingMail/>
</w:WordDocument>
</xml><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">whether to support the &#8216;timeout&#8217; paramet=
er can be decided later based on actual needs.<o:p></o:p></p>
<p class=3D"MsoNormal">at this stage, no known code or scenarios that requi=
res its use.<o:p></o:p></p>
<p class=3D"MsoNormal">the parameter of &#8216;timeout&#8217; is usually fo=
r corner cases and special situations,<o:p></o:p></p>
<p class=3D"MsoNormal">which are not suitable for the &#8216;cmn&#8217; hel=
per, for these cases, using the low-level API directly is better.<o:p></o:p=
></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Best Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Kevin<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Lazar, Lijo &lt;Lijo.Lazar@amd=
.com&gt;
<br>
<b>Sent:</b> Thursday, March 19, 2026 3:48 PM<br>
<b>To:</b> Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;; amd-gfx@lists.=
freedesktop.org<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Haw=
king &lt;Hawking.Zhang@amd.com&gt;; Feng, Kenneth &lt;Kenneth.Feng@amd.com&=
gt;<br>
<b>Subject:</b> Re: [PATCH 1/3] drm/amd/pm: add variant func smu_cmn_send_m=
sg() to unify msg sending logic<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:#212121">The variadic wrapper a=
ssigns different argument meanings based on number of parameters used and t=
he position. It will be hard to read code based on it. There is an optional=
 timeout parameter which will need a
 5-argument function. Just don't want to miss out on that if everyone start=
s focusing only on cmn helper functions.<o:p></o:p></span></p>
</div>
<div id=3D"ms-outlook-mobile-body-separator-line">
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
<div id=3D"ms-outlook-mobile-signature">
<div>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Lijo<o:p></o:p></p>
</div>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Wang, =
Yang(Kevin) &lt;<a href=3D"mailto:KevinYang.Wang@amd.com">KevinYang.Wang@am=
d.com</a>&gt;<br>
<b>Sent:</b> Thursday, March 19, 2026 11:23:06 AM<br>
<b>To:</b> Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">Lijo.Lazar=
@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;; Zhang, Hawking &lt;<a href=3D"mailto=
:Hawking.Zhang@amd.com">Hawking.Zhang@amd.com</a>&gt;; Feng, Kenneth &lt;<a=
 href=3D"mailto:Kenneth.Feng@amd.com">Kenneth.Feng@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH 1/3] drm/amd/pm: add variant func smu_cmn_send_m=
sg() to unify msg sending logic</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><a name=3D"BM_BEGIN">=
</a><span style=3D"font-size:11.0pt;font-family:&quot;Times New Roman&quot;=
,serif">[AMD Official Use Only - AMD Internal Distribution Only]<br>
<br>
This patch simplifies the development flow with a unified interface and red=
uces overhead for developers.<br>
Most developers can implement features without focusing on low-level detail=
s, while complex message sending scenarios can still use the low-level msg =
sending APIs directly.<br>
<br>
Btw,<br>
The scattered APIs hurt maintainability, and most developers should focus o=
n business logic rather than low-level details.<br>
Thus, the &quot;cmn&quot; helper is necessary, it only simplifies the commo=
n path while keeping full flexibility for advanced use cases.<br>
We do not have to choose one or the other exclusively.<br>
<br>
Best Regards,<br>
Kevin<br>
-----Original Message-----<br>
From: Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">Lijo.Lazar@amd.=
com</a>&gt;<br>
Sent: Thursday, March 19, 2026 11:46 AM<br>
To: Wang, Yang(Kevin) &lt;<a href=3D"mailto:KevinYang.Wang@amd.com">KevinYa=
ng.Wang@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
Cc: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Ale=
xander.Deucher@amd.com</a>&gt;; Zhang, Hawking &lt;<a href=3D"mailto:Hawkin=
g.Zhang@amd.com">Hawking.Zhang@amd.com</a>&gt;; Feng, Kenneth &lt;<a href=
=3D"mailto:Kenneth.Feng@amd.com">Kenneth.Feng@amd.com</a>&gt;<br>
Subject: Re: [PATCH 1/3] drm/amd/pm: add variant func smu_cmn_send_msg() to=
 unify msg sending logic<br>
<br>
<br>
<br>
On 19-Mar-26 7:39 AM, Yang Wang wrote:<br>
&gt; add variant func smu_cmn_send_msg() to unify smu message sending<br>
&gt; logic, and enabling support for newer ASIC interfaces such as SMU v15 =
and upcoming devices.<br>
&gt; (support multi-param/multi-response, standardize code across all smu<b=
r>
&gt; code layers)<br>
&gt;<br>
&gt; The smu_cmn_send_msg() API will expand to the following prototypes bas=
ed on the number of input parameters.<br>
&gt; e.g:<br>
&gt; 1. r =3D smu_cmn_send_msg(smu, msg_id);<br>
&gt; 2. r =3D smu_cmn_send_msg(smu, msg_id, &amp;read_arg); 3. r =3D<br>
&gt; smu_cmn_send_msg(smu, msg_id, param, &amp;read_arg); 4. r =3D<br>
&gt; smu_cmn_send_msg(smu, msg_id,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_param, [p=
aram0, param1, ...],<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_response,=
 [arg0, arg1, ...]<br>
&gt;<br>
<br>
The intent behind message control is to make the message protocol transpare=
nt to IP versions and specific IP versions to have more control over them -=
 if they need to override a message mechanisms, add specific timeouts to pa=
rticular messages etc. Overall,
 they are expected to move away from using 'cmn' and directly use message c=
ontrol operations. That also avoids redundant memory copies of in/out argum=
ents.<br>
<br>
Thanks,<br>
Lijo<br>
<br>
&gt; Signed-off-by: Yang Wang &lt;<a href=3D"mailto:kevinyang.wang@amd.com"=
>kevinyang.wang@amd.com</a>&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 79 ++++++++++++++=
++++++++++++<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h | 22 +++++++<br>
&gt;&nbsp;&nbsp; 2 files changed, 101 insertions(+)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
&gt; index a644579903f4..bc2ac5ae6a48 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
&gt; @@ -193,6 +193,85 @@ int smu_cmn_send_smc_msg(struct smu_context *smu,=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; read_arg);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; +static inline int smu_cmn_send_msg_internal(struct smu_context *smu, =
enum smu_message_type msg,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int num_in_args, u32 *in_args,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int num_out_args, u32 *out_args) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct smu_msg_ctl *ctl =3D &amp;smu-&gt;msg=
_ctl;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct smu_msg_args args =3D { 0 };<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (msg &gt;=3D SMU_MSG_MAX_COUNT)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -EINVAL;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if ((num_in_args &gt;=3D ARRAY_SIZE(args.arg=
s) || num_in_args &lt; 0) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (num_out_args &gt;=
=3D ARRAY_SIZE(args.out_args) || num_out_args &lt; 0))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -EINVAL;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if ((num_in_args &gt; 0 &amp;&amp; !in_args)=
 || (num_out_args &gt; 0 &amp;&amp; !out_args))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -EINVAL;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!ctl-&gt;ops || !ctl-&gt;ops-&gt;send_ms=
g)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -EOPNOTSUPP;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.msg =3D msg;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.num_args =3D num_in_args;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.num_out_args =3D num_out_args;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.flags =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.timeout =3D 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (num_in_args)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; memcpy(&amp;args.args[0], in_args, num_in_args * sizeof(u32));<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ret =3D ctl-&gt;ops-&gt;send_msg(ctl, &amp;a=
rgs);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return ret;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (num_out_args)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; memcpy(out_args, &amp;args.out_args[0], num_out_args * sizeof(u32));<br=
>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * NOTE: To ensure compatibility with the behavioral logic of the<br>
&gt; +legacy API,<br>
&gt; + * it is required to explicitly set the parameter &quot;param&quot; t=
o 0 when<br>
&gt; +invoking<br>
&gt; + * the msg_0 and msg_1 functions.<br>
&gt; + * */<br>
&gt; +<br>
&gt; +int __smu_cmn_send_msg_0(struct smu_context *smu, enum<br>
&gt; +smu_message_type msg) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return __smu_cmn_send_msg_2(smu, msg, 0, NUL=
L); }<br>
&gt; +<br>
&gt; +int __smu_cmn_send_msg_1(struct smu_context *smu, enum smu_message_ty=
pe msg,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 *read_arg)<br=
>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return __smu_cmn_send_msg_2(smu, msg, 0, rea=
d_arg); }<br>
&gt; +<br>
&gt; +int __smu_cmn_send_msg_2(struct smu_context *smu, enum smu_message_ty=
pe msg,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 param, u32 *r=
ead_arg)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (read_arg)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D smu_cmn_send_msg_internal(smu, msg, 1, &amp;param, 1, read_arg)=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D smu_cmn_send_msg_internal(smu, msg, 1, &amp;param, 0, NULL);<br=
>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +int __smu_cmn_send_msg_4(struct smu_context *smu, enum smu_message_ty=
pe msg,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int num_in_args, =
u32 *in_args,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int num_out_args,=
 u32 *out_args)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return smu_cmn_send_msg_internal(smu, msg,<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; num_in_args, in_args,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; num_out_args, out_args);<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp;&nbsp; int smu_cmn_send_debug_smc_msg(struct smu_context *smu,<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_=
t msg)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h<br>
&gt; index e4d282d8bcae..f48356c22dbb 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h<br>
&gt; @@ -209,6 +209,28 @@ int smu_cmn_dpm_pcie_gen_idx(int gen);<br>
&gt;&nbsp;&nbsp; int smu_cmn_dpm_pcie_width_idx(int width);<br>
&gt;&nbsp;&nbsp; int smu_cmn_check_fw_version(struct smu_context *smu);<br>
&gt;<br>
&gt; +int __smu_cmn_send_msg_0(struct smu_context *smu, enum<br>
&gt; +smu_message_type msg); int __smu_cmn_send_msg_1(struct smu_context *s=
mu, enum smu_message_type msg,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 *read_arg);<b=
r>
&gt; +int __smu_cmn_send_msg_2(struct smu_context *smu, enum smu_message_ty=
pe msg,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 param, u32 *r=
ead_arg);<br>
&gt; +int __smu_cmn_send_msg_4(struct smu_context *smu, enum smu_message_ty=
pe msg,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int num_in_args, =
u32 *in_args,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int num_out_args,=
 u32 *out_args);<br>
&gt; +<br>
&gt; +/*<br>
&gt; +* The smu_cmn_send_msg() API will expand to the following prototypes =
based on the number of input parameters.<br>
&gt; +* e.g:<br>
&gt; +* 1. r =3D smu_cmn_send_msg(smu, msg_id);<br>
&gt; +* 2. r =3D smu_cmn_send_msg(smu, msg_id, &amp;read_arg);<br>
&gt; +* 3. r =3D smu_cmn_send_msg(smu, msg_id, param, &amp;read_arg);<br>
&gt; +* 4. r =3D smu_cmn_send_msg(smu, msg_id,<br>
&gt; +*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_param, [para=
m0, param1, ...],<br>
&gt; +*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_response, [a=
rg0, arg1, ...]<br>
&gt; +*/<br>
&gt; +#define smu_cmn_send_msg(smu, msg, ...) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; CONCATENATE(__smu_cmn_send_msg_, COUNT_ARGS(=
__VA_ARGS__))(smu, msg,<br>
&gt; +##__VA_ARGS__)<br>
&gt; +<br>
&gt;&nbsp;&nbsp; /*SMU gpu metrics */<br>
&gt;<br>
&gt;&nbsp;&nbsp; /* Attribute ID mapping */</span><span style=3D"font-famil=
y:&quot;Times New Roman&quot;,serif"><o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB297226DA71F3FADC5F4C1E6B824FADM6PR12MB2972namp_--
