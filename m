Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BC9C3ABAA
	for <amd-gfx@archiver.kernel.org>; Mon,  5 May 2025 19:51:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB80C10E29A;
	Mon,  5 May 2025 19:51:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VivOEQv5";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D05B910E29A
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 May 2025 19:51:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rdnwqQ0kCKMC2TM/ZS30WPrTkTUfUeLsdheU5r1EFMtI/pIrlBqW/wZ6rIvXJiTypeioj+Js980lBIehFmOFRx6Qg14gzZFpAzvqKh2kRB0ix7ttxteZprr5CyecwaituYd8XgKyeYVLTMDwoqGvBgserJGgqO/k7WuqdhW/QG8M0A4/TnluZxbvL312hriQVGN4tK6OnzyD3/ueXnF7TucLlIhwadr1tsGdFTla9P6u7WiIv/4sP8bSI+9EwHkIf9ZkjEk+CIj2gq7TcdWPgT1atmZa6BXX7zYmqoNgyKW5/GJ7pTXtY8l6N/Mfai5GW8RT1RZmvr2EGuKQU73ZuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phlctkbnyrnIUUL/dw9A4l0X1nn+2r4HPCqZKLQ5CO0=;
 b=kJZGnMEd0b71iTSpoy17LhbkNNQCodhHE7SfVWlVDXsTJhcYQPhue2uO1mFyBpAKPS+dDhnCcOC9BMUCBeN7M5fd5enrW1XOK80cfJ0hvOgPUB+wB73a1p4D1v8AwmGOl7quTbwqhsIwP6jgTpBBFAQTS8WgOej+25IprnyJMPhJL1VK8mtvBCkiOQ2gm6H0pj/znWK4vdnBo7EFbNJujOv7fwMcWJZHvcw0z3X6oZ3UsDWzix4ClkGhzmLoc0tPc608fTLLI5DNd4bsH4Mxw9gFChGEGykOtzEnLW+NwyiCiK3TdHFXFW0RtPkUmdmFD6JNVzOPB9i+B4sirmiwBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phlctkbnyrnIUUL/dw9A4l0X1nn+2r4HPCqZKLQ5CO0=;
 b=VivOEQv5JQgS7stnb2StdhzC/lAIx294LMWu7gp8PnmBiJCIhJZ4T4Nnwh6dDmoHTJ3Gqom+l318mKNRSBiAtf2jC3mX3VeNZijtHsELDEq4eZ/UKSXVaF0gaRo0ViOFfZ6OgbDfSoS2r8X0RcbSPWRAQKkqeDyPN61jXFp5HFE=
Received: from CY8PR12MB7657.namprd12.prod.outlook.com (2603:10b6:930:9d::14)
 by CH2PR12MB4056.namprd12.prod.outlook.com (2603:10b6:610:a5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 19:51:27 +0000
Received: from CY8PR12MB7657.namprd12.prod.outlook.com
 ([fe80::dc50:9698:ac9a:b44b]) by CY8PR12MB7657.namprd12.prod.outlook.com
 ([fe80::dc50:9698:ac9a:b44b%5]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 19:51:27 +0000
From: "Gande, Shravan kumar" <Shravankumar.Gande@amd.com>
To: "Pan, Ellen" <Yunru.Pan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>, "Rehman, Ahmad"
 <Ahmad.Rehman@amd.com>, "Chan, Hing Pong" <Jeffrey.Chan@amd.com>, "Luo,
 Zhigang" <Zhigang.Luo@amd.com>, "Skvortsov, Victor"
 <Victor.Skvortsov@amd.com>
Subject: RE: [PATCH 1/4] drm/amdgpu: Add Runtime Bad Page message definitions
 for VFs
Thread-Topic: [PATCH 1/4] drm/amdgpu: Add Runtime Bad Page message definitions
 for VFs
Thread-Index: AQHbuU9RuMUTHy5fnkOP2m5azwgtKbPEe1Lg
Date: Mon, 5 May 2025 19:51:27 +0000
Message-ID: <CY8PR12MB7657B6E6DACE531D24DCB73B8B8E2@CY8PR12MB7657.namprd12.prod.outlook.com>
References: <20250429214008.93058-1-yunru.pan@amd.com>
In-Reply-To: <20250429214008.93058-1-yunru.pan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=84a32dde-25a1-4c59-9c7e-3d0c7582bd12;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-05T19:50:36Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7657:EE_|CH2PR12MB4056:EE_
x-ms-office365-filtering-correlation-id: ff700c8c-6426-4677-ea0a-08dd8c0e392d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?06RbRBMlpjuxp23mfARShP38TDrsi9VKspwdcTfxBN+2a/v/41lZEEmMehLc?=
 =?us-ascii?Q?zqi6hDdjEyykC7MRWCq6eLbvCjGabh6FM7sGuMJVCDJxYVH+/UiAcdhoz+2+?=
 =?us-ascii?Q?lGVU+kpI2DMDXtq5T6hoAT4Dl+7BrvdXK+wMr5ZIwRqOcukESGGM7L22ilJc?=
 =?us-ascii?Q?Cq7A+Eq4buFSpc9yMtKjIrViISXNgSGdPqdgrw/GZw/OMZYlYG5PJ/CG3Baf?=
 =?us-ascii?Q?/KT3Mxt2WPUylaei6DalzzBJajR6gl2u2FFV49cr46ZjtdHYrGz4tyMzLQag?=
 =?us-ascii?Q?blmBwiYU+iURzfKZ06XtMKJwKlH+FmzraxX/Ovma5ggvSTmstW+QbhiI404/?=
 =?us-ascii?Q?gSyxEhVxZCIBvF+i43T5Xl3F1OkrsvXk9lCwhYKIj4KA0tci/cMCKZeBWDjx?=
 =?us-ascii?Q?vLTmi6kv37SAZj/7W4s8+2+POhOm38oZ7zfQnrlLzWnpfI3i8ZJxxLXuSgNA?=
 =?us-ascii?Q?9nFIQR9YAXPmz93vQ99FLaYUSyIPcKZO+FmcBT5uMnHt7WqmSXs+UxojWMgf?=
 =?us-ascii?Q?saYWkHaISHSqG7dJoiD4YweU/amfU2vRPbvbosFZoo1Z1yq9g7eaTaDm84GE?=
 =?us-ascii?Q?dY/8ZRgW3g2nr5xQggKXT3lv+MBlBR7wZYaW7dKgyvUEifkvaYkHW4OVYhMQ?=
 =?us-ascii?Q?jpJEtg8+selsvdGocXYxau7zq9eRwWzLh1nITMab0QjzexhQ95I04Rt/TKiJ?=
 =?us-ascii?Q?pKEo/8/t4A1t4ywLKY11izJ6HqMOx0Wi9k3eNjrqgum4WrzyggC7fKIZ0RCR?=
 =?us-ascii?Q?afzb4AOd4tu2e2lUGOmGuFabwQYP1fQVAbVbcoR0UyZxLPekYDOZXMmUJRm8?=
 =?us-ascii?Q?+FaXFjVKIJrYTQ1+hxhPd05gbALEIx2DTnf5R1l2esBAKeI5NvofKhlWHSve?=
 =?us-ascii?Q?2gQLM4216HfvqAS/CaaPiCWKJ2fUkYM32u/rLa7ASs4F3ObXteTZyYCRLcNS?=
 =?us-ascii?Q?j14Q16tyVfJjeqjXqFAhh1zUX5FArnyNXGij4TqT00CaD6YbjzX4D2mc5ZDS?=
 =?us-ascii?Q?uqdbBrPfHPWtZt2zYvQ69URnxIw28ZcQ5qsfoIBpnbHPkk0dlXyKQ4pAI3sA?=
 =?us-ascii?Q?U11djfm3ppgp6+iCs5y8hlX9dVt5oPKeVHViEk4gUcRP9rscGhT5yvrnOnUg?=
 =?us-ascii?Q?5aDQRSqc7wEgE91XJJKzXRDGiHZf7cibIyjRKzihSlkjzWFHo6SRTP71gZXO?=
 =?us-ascii?Q?OTd4KIntatJsTRikMgfl00CxxMPn4mK+8zrMVRhS69sVHc/UJAjOYi6sF5zk?=
 =?us-ascii?Q?08pu2zDwG9Nb5mXdxGacTNVmp1fqsaXnuuLFUI+TNA4KiGupJEYrFPLahZO/?=
 =?us-ascii?Q?jODdpg+afCITQtF+0b6nkktwwOXAD5xrwNx9ZyZFeP3F1Cr21fwJD6r1eD7J?=
 =?us-ascii?Q?6s14CpuuuQhsq+Heow5PeXekclb1x2e7glVnQD01zIGNuMMhlBYsILFfZ+qD?=
 =?us-ascii?Q?nUN5wEq/0EQpi/yrZzPRBJF8t3HVGQkHHSDPXqGVrizBvJT50V+CIQvCr7Qz?=
 =?us-ascii?Q?rRS/QHGE18vnF08=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7657.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uEGhjEDzrt7Rue1pdt7G/6MTmde2M71jUwbqGTa3Bo1/J5PMmSEcYMh7cz5r?=
 =?us-ascii?Q?nL36Pw3Nb4VHnIY+Zn30rn8/tQsEIr9IryP2XKbB9XKEIWW6iizgJzSn/ViX?=
 =?us-ascii?Q?XLbid8qp1waI+ZoM87j33VFvsFRgj2WhNY72Hkrb+wTIKYh3K8W38N3P7GpK?=
 =?us-ascii?Q?JTe90B2t/C5hZi0Wx65Iom0KJo9wsZac821uS6AULCc37Hqc4iRgRHzeYGz6?=
 =?us-ascii?Q?4zxpSUHK3Z1RiNTr6UzZHouBTYuaATp+Y3hGR/RQ2FgJYwIWM9X9SRCACju2?=
 =?us-ascii?Q?0lUyDDB/L38wywlH5U/sPbmxqjY/H4kmq0GRdf+DQIEanK+gnztVqJeyMvaV?=
 =?us-ascii?Q?QJzOpn8zKhK9q/CkRyYjlo2gwvv3LEOQJFueMq6FzHFQVmtWAiNFBxG8++cK?=
 =?us-ascii?Q?X3fsMPUnkpmnOKKVTgFnkJO8xxMxZ5oqBbOYtHqzIyHaghXEqMvTKn9UGhZs?=
 =?us-ascii?Q?5hbHCEsNMo5FNkGmTo3Tc9n/DCrrTI8l2UlOJk7G2Q8mBNfMIh9BIpzhScmc?=
 =?us-ascii?Q?iVULMW9WYtCn+fvoP+UKHKaJjD6L4L+WW8KH3h2zexn+ZfPJPAn9XuPJB9Ix?=
 =?us-ascii?Q?sf8ogYYgEBTmVS1yp3+fGw8NuC+JLuso8/d7S9DX9LFRCRFUkZqIeLZqDB4Z?=
 =?us-ascii?Q?1Axeijw3SDv/CMZnkoBqGFg/rJX7pUtl0GWV4VWO3xy8ejm0bgPAXCWYLyZ+?=
 =?us-ascii?Q?5xyfH2BYCKb4E8g2aW4s3gXphV5J4IBP5aEU2GCa2o8m5jWnYkhRl2WdXaDM?=
 =?us-ascii?Q?SU22Rg1haMCogA6DJFQiahpVfUStBEi26ZNPLkYNgxSJaJ09NOiyuM+pv0i3?=
 =?us-ascii?Q?a9l1GpNaNKA8jMto0SH2YDeP+43D4OvjitoPcc5/OSsSxESbD6xb92MiUIfc?=
 =?us-ascii?Q?dF10StI8URrfP3uLdX29O4ZsAvK5tqpDIg8mBeg44tLC6AncuM8lzTP19vBc?=
 =?us-ascii?Q?g/0M4/d/RhCfomJiUSy2FWSnkK6XXtsaSMDeG2HTC2UjPz3zm2MYSEv/eAaZ?=
 =?us-ascii?Q?3PtCfZDGEwa/sMOA53zCajovDCRI1+8jFZk9OkZIhvdOq+/F3K4EUedj3pjh?=
 =?us-ascii?Q?UT0gdiu3/VQLzZ6jcOwkSTx8MF6aq5C1cEThhN2TtvWrC8r54u7dPxg1fGIv?=
 =?us-ascii?Q?k5/THZU4s/f8KbBlGUOTOH+S9SxfAKSIrr/0+Y3MJXi5zuzIyLg+l6ul65X2?=
 =?us-ascii?Q?uK8Y0CTkQHckNUnDhraH3/UJ3c7vNu0ngaL/2e/MtYc6oMyRTrbqji9OQ48m?=
 =?us-ascii?Q?hNijIPj2Lfsm/eXw6Gj7MRI6zorpb6l3t5+nFrc6xWNhyr1WJP/F04HTp0nR?=
 =?us-ascii?Q?b/5NLX8k4JKzkiGrq1k9vcB20/HxvUsTK4It6ShGbSBc7cJiwB5Dtukzf1jL?=
 =?us-ascii?Q?r2RH/lVC0O1i7aw0Ux1eeG9oZg0P2HuJ6weaZjwC0+zH6ghgq+R/KIsAt3Js?=
 =?us-ascii?Q?Eu2+h54hMX9zCJa05ec/mRELVPXgfPG4NJuLVkfMb3iMELjGAlvf5xIhMm2v?=
 =?us-ascii?Q?btqmf+k+UMbCkgtJPCmFjAb3ghpjYQ9wtTtRuodtPTTWoTOTQ7pt1KTpzV72?=
 =?us-ascii?Q?yV3rhaxa966TRsHF7l0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff700c8c-6426-4677-ea0a-08dd8c0e392d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 19:51:27.3128 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gaTajEGFoPshaS6jD4lJB65UbhzTrkxzLUViQwxL3N6K3ezltyZdZst5IsZganUL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4056
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

[AMD Official Use Only - AMD Internal Distribution Only]

Looks good.

Reviewed-by: Shravan Kumar Gande <Shravankumar.Gande@amd.com>

Thanks,
Shravan

-----Original Message-----
From: Pan, Ellen <Yunru.Pan@amd.com>
Sent: Tuesday, April 29, 2025 5:40 PM
To: amd-gfx@lists.freedesktop.org
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>; Rehman, Ahmad <Ahmad.Rehm=
an@amd.com>; Chan, Hing Pong <Jeffrey.Chan@amd.com>; Gande, Shravan kumar <=
Shravankumar.Gande@amd.com>; Luo, Zhigang <Zhigang.Luo@amd.com>; Pan, Ellen=
 <Yunru.Pan@amd.com>; Skvortsov, Victor <Victor.Skvortsov@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: Add Runtime Bad Page message definitions f=
or VFs

Currently VFs rely on poison consumption interrupt from HW to kick off the =
bad page retirement process. Part of this process includes a VF reset.

This patch adds the following:

1) Host Bad Pages notification message.
2) Guest request bad pages message.

When combined, VFs are able to reserve the pages early, and potentially avo=
id future poison consumption that will disrupt user services from consequen=
t FLR.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
Signed-off-by: Ellen Pan <yunru.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/=
amd/amdgpu/amdgv_sriovmsg.h
index bea724981309..3b0c55f67fe4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -331,6 +331,7 @@ enum amd_sriov_mailbox_request_message {
        MB_REQ_MSG_RAS_POISON =3D 202,
        MB_REQ_RAS_ERROR_COUNT =3D 203,
        MB_REQ_RAS_CPER_DUMP =3D 204,
+       MB_REQ_RAS_BAD_PAGES =3D 205,
 };

 /* mailbox message send from host to guest  */ @@ -348,6 +349,8 @@ enum am=
d_sriov_mailbox_response_message {
        MB_RES_MSG_GPU_RMA                      =3D 10,
        MB_RES_MSG_RAS_ERROR_COUNT_READY        =3D 11,
        MB_REQ_RAS_CPER_DUMP_READY              =3D 14,
+       MB_RES_MSG_RAS_BAD_PAGES_READY          =3D 15,
+       MB_RES_MSG_RAS_BAD_PAGES_NOTIFICATION   =3D 16,
        MB_RES_MSG_TEXT_MESSAGE                 =3D 255
 };

--
2.34.1

