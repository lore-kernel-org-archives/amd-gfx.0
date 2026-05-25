Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7633CD5BAB
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 02:24:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6752E10E011;
	Mon, 25 May 2026 02:24:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BrE5u+Ee";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013050.outbound.protection.outlook.com
 [40.93.201.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B92610E011
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 02:24:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JuZS18h6H+jTkGOx1qyZfpgGCVs4cd3V34dvEQ4hcPelkI0E95083WO1WhPakYlz7YBlsevjEPO+Je+ZIyN8hnpvx9qyxcLkFE+e80csBCubhY1pEYO0tbPsnKnl5kGaybBrLUUgJcP4tk7Q0A4A/JkJe5332QEDQRhUGlGXiGtd9V0wIjnCDaC22WrEmIeJLdudgHG95xLOLXirX6TwgeLxdrnR++K2FZiVd7z7/4ytHOUxJp6uHwziOxAhj5UaAdbp5ffCFlTtpDIWPaGgZ8OZ4a+GjQscgVQGBDoYI8GoU99egHuyRGXc8E12U/DH/3dm7ALbyrOzvKTjUnhgLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tzg9d9rUJBSoAlVmoDDm5uvmEWmwuLy5Lowc0+7O964=;
 b=RDuHsWAMCS/PuS5d/5uv7VwMxh4lzOyeNYiZdHqWYk3vA3m1rmKXRT0liPOeRLJB9TMqz/gr4qh+iag+AewFNVTHjkl3raIMAq6ELhRPB6Ayj/IbdWQEVKsy+aEpZQP1z7snGAdcsblybfd9CStbmskL4RQRHBACA7S6ZKYhQh0Bi+Him9rA4ld61HYq8tDieH/kDeGqULeRKV9QN6cf+NYslPMlLnAFyR7AOKN26UL5uHg0oyY9fqcDoyaPN0xCc6VbygfxGi31pxAwbJgwb/M5VFQP9U4ogqLBBeIkGcyF+yuF4fMNqyW4/5QV+tEXs71uFDH0qNKE0DEy9czdaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tzg9d9rUJBSoAlVmoDDm5uvmEWmwuLy5Lowc0+7O964=;
 b=BrE5u+EeKiNn0RZLGcealbHdhqJh7vpjbcrICxas6ULMEcisKbiOiKhHv6acIr6ToBsxphTeUniD2JvL44G+1qNDjtlxJEB0vBo31S7OS37EfLO8tyGPvMiZPo54Fi4Mcijxx9RRCIJxS4ClEmNdjvWxlNGA1lfSfba/Y7tV7aY=
Received: from MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 by DS0PR12MB8415.namprd12.prod.outlook.com (2603:10b6:8:fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 02:24:13 +0000
Received: from MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd]) by MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd%7]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 02:24:13 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: apply SMU 13.0.10 workaround during MP1 unload
Thread-Topic: [PATCH] drm/amd/pm: apply SMU 13.0.10 workaround during MP1
 unload
Thread-Index: AQHc6+LyhF8+FYYSA0utJXkgla/KoLYeAv9Q
Date: Mon, 25 May 2026 02:24:13 +0000
Message-ID: <MW4PR12MB6803EFA84F97B7F69BC220E98E0A2@MW4PR12MB6803.namprd12.prod.outlook.com>
References: <20260525010753.16210-1-kevinyang.wang@amd.com>
In-Reply-To: <20260525010753.16210-1-kevinyang.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-25T02:22:50.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6803:EE_|DS0PR12MB8415:EE_
x-ms-office365-filtering-correlation-id: 9c77ed65-27b1-404f-89c6-08deba04b643
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|22082099003|56012099003|18002099003|11063799006;
x-microsoft-antispam-message-info: +TyuBec9BGkirY7meo1FUwcofGsykvz+3q4m2Z4JMLqWCIljWtvXxgoogZaYl9LOQ5z/rF+pugivRCtbL8GGGPy06Ff0NmVJ5esekfG1Tx9AlYsJNgMvHjtrpU65Plm2j8PLzmj4fbTXI9WSik0zfPO/z7D7XHYG0r/o1KLH8Hfu8gH78zfGk2kRDwApWFsXViLh2lu6D486fuKuUORDeu7IfyshqNpMxRWbYxHgiSXPy3ERd6j6uRSi1qkKYM1RzEuSRcuG6URdOnaBybvVue40fl3GP8/Vs1I+2ykT13qZBd1TbrD0hAMqlzfki1XIbRhfi2wUWZ7AH4qVKjc23bo8n2oTsket9zeubbKuS5qcKDzM+SJtgotnnQiJqSbmWYsSe3q1VK9iep6byKoVETH29K8hq9bxDq2byc2LsHAd8V1PO4n80L1K/k9ezY0HAH1GCTNkq3RQGayAMoHXCn9yd8Y5ypUwINqXoJjMT4rj+MIkPUvNAwj2yXnlGTu6lljyWeGxAhit9JlpuQtQBW7h2QI+TXIDvx5elsNSad3ruGF4zHrU1/aDv/c7u2ONeiPij276zno118+LIrX1yurVqtbOWTFbf578pUzWhOUZNaKUsSFy4TlihL3QTQBHwPxM8vvUQqMdV6YVdE/vPK8nM3KbYiYGxeVUwstcGrPSeJHXs7C/wL/yl5D7kp07+MMcurHsHjkiLFzWLyApzw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6803.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wldcfJ5jMivsHOAVhPiM8tI+00ymrQ/RakzsORoX/9R/0SWdoP1MBMeDtZd/?=
 =?us-ascii?Q?CjeYg6N0KygnJs63gZvNO7dPLSh6Yjjamvj2evgNY+svJiYTt5iNDqoVCxGJ?=
 =?us-ascii?Q?DcHuh29dGswT1OKXBrpkNi84bt4lbphC2J0/mi0eaqZrkqdLMDnS6oKHRM1p?=
 =?us-ascii?Q?Y9gEcgRD+vLaUgJqVQIGNchV9Go0XgjqblDUPX+FIi35VtgwNFvi+q4MoHZ4?=
 =?us-ascii?Q?bj+W2zL020miweeL745bpEdlbSD/8nvg20cvBTBgS8fi9ybZKwj5Ey/9BKIl?=
 =?us-ascii?Q?KXxOUK+7eE/4XMvTmsfuyu/WgBekIJ+GnsNieuBdqlayd5+BbW4LK08DxWG6?=
 =?us-ascii?Q?xTtsn5EFw1095d8FRjW+/Woej9mfrWVvvcul3o8DVSJ9PwUmv9zsH5/gSJ3V?=
 =?us-ascii?Q?bhyENkH94Jeu6hDr/BvFmcV6DSiJ1wZ6X5tud0wpTl3hQdx8UdvaLK1z4/Z4?=
 =?us-ascii?Q?NGOe/c5eq085eJzGcyZ206mdXWbHQubV5Ra7ESkAjpDpnQtY/9SRe1mfSMnl?=
 =?us-ascii?Q?dlYhNMzyRLiXiykF0ju1xpia+jIAG2Vv0k+C72IHmw1OzNRTWkXPS8EyW5O+?=
 =?us-ascii?Q?NQq52SY0jrK9KbmtOFFLiNBwHrsM1J7Q6nBg8xIwrBMoz5bwKmgf9qn5nbTP?=
 =?us-ascii?Q?TYORbsJru4OG47VLEJyaycpyjuJJL0iFySZiZOCx/vzZOGxnKsibu3vtk4Xt?=
 =?us-ascii?Q?JlpEH+7V4a5drDbqYdQknl7fNtQxR0/ODsPg6cA3nTkLjteiRcjOp5pXMus9?=
 =?us-ascii?Q?Y32/cfnzx3mJTivZqy2XIbqIk3exfL7jBZ+cmjmSVLcv31IbsR+vw4CXdXm3?=
 =?us-ascii?Q?GMWq0ud6m9oE1T39zhf95TE/iTE+eSFP5YExyozYt3sBXIFr/CDclBHpo1V+?=
 =?us-ascii?Q?cjnukot8xOnhhLKyvDT4mlW1wNWYzt6fDbp71UoS5YGFDlbiDj/VJQfTjRGM?=
 =?us-ascii?Q?kvAWvYXae4fl7cGZQ/1vNgFdfh3CmngYhYmB7mploLMJvYzq6nXHYpTU2hY3?=
 =?us-ascii?Q?626Ww0P7An78l0BUKqmn2PHbMniRHPts8mMy8vuIIapPcr9Ti9RT327KtcBh?=
 =?us-ascii?Q?AQ80dvBaYXZhinC1uBe2BR0sVLKbivFmXp6TxCKiS6CHNYBnYsLnL4jf1vPe?=
 =?us-ascii?Q?kl242A+WfuSS3N4tZ2tKxYYSwPUuJFednU2oh+022Mz+DYDUZbNjIZS1gn1z?=
 =?us-ascii?Q?r1emjXOm3xcVrQlrvCL5EMykbhoJlqBjRipCy1MZjUFAD0u6IegJeTJ6td0n?=
 =?us-ascii?Q?RtKXu3escFpB4aERbvzzzHBmipRQK0vMrvjPiNBuI8ohR+P2P6X8zI9F5dRe?=
 =?us-ascii?Q?DVZ7jIQ2hA2O/02cpj0PzImB6eW0ADTQZLi4n37CkaoD3kxXTby648kLB0dH?=
 =?us-ascii?Q?zF8xc+kFppRJIPtSGUiw4uZN5LqUKNomDZO5fEpmtzi7HI7SVwK0sbcFGPw+?=
 =?us-ascii?Q?JRR3OOV0OuZYSQr9zRhi9ctnM7BAxWRVGCd7mWVRGUEojPzwu2vAWEIjkh6S?=
 =?us-ascii?Q?S14/c9Du75y7xuMpHPwr7fQsLOwUZ8Ln0N32X5ak5tFVC7WAKViwxV3DVeYb?=
 =?us-ascii?Q?2nPtBdVbM92NCRPMiJSm13qTEh6lHwi3igMip0W1TJSrux0hBU93MU+p9pg8?=
 =?us-ascii?Q?w/VtuIllJFL47GUInMUpCZwhzvWMzWL8mHxo74wTOXK/ldB8inz6RK9OEtFE?=
 =?us-ascii?Q?b5I6Je1sm3mnFjfSIov0S8tmUEg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6803.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c77ed65-27b1-404f-89c6-08deba04b643
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 02:24:13.3421 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xtqnIKs0Q+AuvE3KYHw5WNLl89oY4Sf4B0jGjeGjx7eWd9UKfnOY9vk8FRqT0803
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8415
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

AMD General

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Monday, May 25, 2026 9:08 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: apply SMU 13.0.10 workaround during MP1 unload

On SMU v13.0.10, sending PrepareMp1ForUnload with the default parameter may=
 leave the device in an inaccessible state. This can affect runtime power m=
anagement and partial PnP flows.
Pass the required workaround parameter, 0x55, when preparing MP1 for unload=
 on SMU v13.0.10. Keep the existing behavior for other SMU versions.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5133

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 9e74a5c4be43..8781cd9f10e0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2806,11 +2806,15 @@ static void smu_v13_0_0_i2c_control_fini(struct smu=
_context *smu)  static int smu_v13_0_0_set_mp1_state(struct smu_context *sm=
u,
                                     enum pp_mp1_state mp1_state)
 {
+       uint32_t param;
        int ret;

        switch (mp1_state) {
        case PP_MP1_STATE_UNLOAD:
-               ret =3D smu_cmn_set_mp1_state(smu, mp1_state);
+               param =3D amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D =
IP_VERSION(13, 0, 10) ?
+                       0x55 : 0x00;
+               ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_Prepar=
eMp1ForUnload,
+                                                     param, NULL);
                break;
        default:
                /* Ignore others */
--
2.47.3

