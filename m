Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B59CC3ABC9
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 19:25:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B53B110E5E0;
	Tue, 13 May 2025 19:25:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I31Hda8G";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5819810E5DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 19:25:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f07pQ40XNgEYjzMrSuteETAobVHz74e6AD2lQHqFBQY9e0uwP/0sudn+/twMFsVD8VUKTP2tGZBLxqFgkHTVDht6TdQM0tokhymV6+VHYtftVBolZKSYUJGWAKXaBs60ncBe0pfeDiDGH3xlYamhJaY5r2iv+Rr0TpRbFBRPejIsbrXxIxSlf5YXT6RAUuasvkQ/TFuzeuLhZVImgIWSU/G6PcqXMYjy80PEl2X7WvbHaWJ3CrBU5DkfDnTZqFc+CgJRqHBBPmnNjFJqAYrjfaWT4HMsIRGbx3yF398i7fK0c6l9cKc00XroCNomnIAKU3ff+w5btJWl4jn5fvST8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJD0BERTjZA+ehfO11PD7W08fYDnms4jkC6f4pNoSII=;
 b=Lb+9+FFKcjVCI/wwAtsr0EHRkbIwZG1PBeoObw2iM1ede3yYDkslOy5JPSQzDSIFP9Ad/zltSX5slnjVIovg0h0bU9apdnqa5u2dTA8LEE1Cid/06JxqJX6ttc54F60x7MyRcHxSaTGAK8YlKfOqoZnwGyh6eImeBSXT4b9rTgWutMXcwQge9kgCemfxLT05tmpvVobol7TqRBcllBiECHOiod1B4rUjdHhNO92S3Gma2xa7wOv5sZlVKeE3O90EAGKG8k8MP0Ad8kwhkxAIPDfvLnSue3AAjDjzhNjKK3VmM6Czaycve5/MDvROhR5jWvw8XuvL8JcuX9V5HufJrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJD0BERTjZA+ehfO11PD7W08fYDnms4jkC6f4pNoSII=;
 b=I31Hda8Gz74Jd2//FWRajUEyh4DYYPHUD4VKGW7o8Sc71dlL3cgAMqnQt+rBjx2BGG8AbXP//SRxNNjr3kkpsY7Zuh5faKfzJ94sn5H8rhuDpR7L/uAzSLKOU/1XeHS1a0lFRbKO//EdYE8ZsnDGPHOUTPT3R7lBpRNgoODY1mQ=
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12)
 by CY8PR12MB7635.namprd12.prod.outlook.com (2603:10b6:930:9e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 19:25:28 +0000
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::df0b:3ee0:7884:c6a9]) by SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::df0b:3ee0:7884:c6a9%6]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 19:25:26 +0000
From: "Dong, Ruijing" <Ruijing.Dong@amd.com>
To: "Wu, David" <David.Wu3@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu, Leo"
 <Leo.Liu@amd.com>, "Jiang, Sonny" <Sonny.Jiang@amd.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>
Subject: RE: [PATCH v3 3/3] drm/amdgpu: read back register after written for
 VCN v5.0.0
Thread-Topic: [PATCH v3 3/3] drm/amdgpu: read back register after written for
 VCN v5.0.0
Thread-Index: AQHbxDxS2ZbMmtJhWkijHeZ0JUw8CbPQ8NWw
Date: Tue, 13 May 2025 19:25:26 +0000
Message-ID: <SJ1PR12MB61943292A99A1AC86E7B5E289596A@SJ1PR12MB6194.namprd12.prod.outlook.com>
References: <20250513192148.646359-1-David.Wu3@amd.com>
 <20250513192148.646359-3-David.Wu3@amd.com>
In-Reply-To: <20250513192148.646359-3-David.Wu3@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c7e16db5-a80c-4345-a60a-2dbf84583965;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-13T19:24:31Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6194:EE_|CY8PR12MB7635:EE_
x-ms-office365-filtering-correlation-id: 85ed7fc5-6fc0-4af9-83db-08dd9253e9fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?8jb67zRvoRoP1VT59y50bURyB9ilT096pvXYRFzbcW/rto6ECV0WfQVYYPu7?=
 =?us-ascii?Q?7YnmYo83LT2brI0j5PEk5xcyu2bEQke4tumKaapANVuH82KG7Mv4d/EQlHFq?=
 =?us-ascii?Q?l2RlK347hWgdozlZ3etrj2s6SPHlwwKTBWJhaMrf3hn+4akj2PNdO8JHiqH4?=
 =?us-ascii?Q?mfp2Yv/UFyjcsonBrMASlYXIUhAfevv0e5aLsl71fYzK4RfqfDtuQEkwRZQi?=
 =?us-ascii?Q?xX7XypmN8CYgS8uxxpuv49zsaTeqiEk+PfDqY2p2HNaEDijZtbVDdpm6xpJt?=
 =?us-ascii?Q?LfkBJ6/1JHCaHQd61I7qoyevwgq/m8r3IuNGZol6pMdSYRuHgcPUyZ/oosEr?=
 =?us-ascii?Q?WymIteTfHfAX99+AR5aG1TJo9B57NFuHbmwYDv4q2Dso3urmBx3+QyZuGgWT?=
 =?us-ascii?Q?N9BksCV+EkUF+mhvYkoqG016hR17dOUP9gv5smnJeEaIWzferxaonQMdsL4V?=
 =?us-ascii?Q?GClr62zL+QZQY4izQ1B42fUiKN0saSQ7qrjCd68gfAuri1gHhXEVxBXTGhaN?=
 =?us-ascii?Q?mwj+wFqEFhLwAGvlnmYVLSWEDEDELUDD5n+Z3Sy2/oK6x1rl5C5c00S3z8ZY?=
 =?us-ascii?Q?k9ipzBOcKJJ7A2aBtBAtOKAcZ1yaVUUmbLgK188cnHI6nu59IkRUTfMfRjbN?=
 =?us-ascii?Q?YN5Q3EJFfuN0/MRCbth6U6y87U+pDXozChm/KphpgJkXTzNOLECF1OKLZ6Ve?=
 =?us-ascii?Q?2sYCZDOcCSMcikF/vGZsXsNQG3q+xCQfiUUxxGfrGOXFZHpGz5ubIF8LdAV6?=
 =?us-ascii?Q?7e+NpFaJzmou/8WdET6Q3reZkvULat4Bj8Sv/VLAXLvR9b/L0CIY7x0Zr0dP?=
 =?us-ascii?Q?bFStRv187TneHOp1FPPTk19Op0m2tnHSxcKJ0RKVvfck82CRqjCGHWW2YnPE?=
 =?us-ascii?Q?p3myVtF2SnAHNj1eUIAuSpGyHbLQHX2zobVinJjAI5iiSSMABJ8yqAt+pRDU?=
 =?us-ascii?Q?cIgJEJVeAaXaPBcJeTuZmuD+TqSNjTCTQkHuQlIog1sYCmYhCISowhXH7aJR?=
 =?us-ascii?Q?/mG8kA8EEqyW+S2SiG+7w3yX2WzFzFBHGIgJqCyW7hqcwD73emnBrwqpHjve?=
 =?us-ascii?Q?AQjP4j2tpJauTuRm2Gm3orbhHGIoYNUFL56pTQWFEHDKxWusRsVj6MXgS+Vz?=
 =?us-ascii?Q?zMFE6lao6gVc1XzJcRIuq5YjCNkRC/4au2HOM7qcUmzNcXkFnt3uMw6qY/9o?=
 =?us-ascii?Q?kEF+2gUNvgU4xks79G03aKQBwatuq32haucsyH7Y5wl53e2qbWeKtP1JvyE3?=
 =?us-ascii?Q?SzJ0gYFFhVWCXiLW06PGanzoCNovPFJbotY1jrTKNucl1UIiOaClUJb/bp6w?=
 =?us-ascii?Q?gsp8EEIEr/BoIBHsv1f+1knSM8EBSPLdO14SYByLOuQHxQ0MO57GTch3NoRH?=
 =?us-ascii?Q?E/yeOtzwaLpgBxxguts8i1CWfOqV2nWIVRzF0cFiT38JyCspbTiU+6qPw1z+?=
 =?us-ascii?Q?l1+NJ+zsl3tL/jlKY10RJbRN91TuNq2edm8falRccxcB92STWbksiv3l/IbO?=
 =?us-ascii?Q?1hqsEZMvbh6wnFs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6194.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VGTyRijkEMzar1Wxq15Orb5cH23owhSv4Wkhm6VVJ5x4GNavLbm3dY93DU74?=
 =?us-ascii?Q?gW7uryqtIJ37qOMowywkvQeefz+Ye22fboSPj/MZkjjtqHOnTdkw9wGURdld?=
 =?us-ascii?Q?93TVMptwWNATXFDSA6ETwffMDsJj9LOD+np1YRFlc6oO1ODkkkF/Hl6tk4Fb?=
 =?us-ascii?Q?lU4LyzoeLLU1bGy8Qn+TRlW7xub2k0n6SOJJxyKklMrgKDpub/dW16bkc3kX?=
 =?us-ascii?Q?SOZPJUVvSTtdr+77hnpUVvz/vjhUxm5OSe6uROTDP4gsAtd3qHTzyuFxzE4X?=
 =?us-ascii?Q?4+t0XDeG4aF8fdHVNdn5/vTPKJGyca9MZOnJcuHtAUHassbDyR6DI5aOnfxw?=
 =?us-ascii?Q?Zf+qvmMNGyVtzMnvkd97JIF5mTEDd0G7NJb89ZBvMBvbhe4tk8vyRw/oiCDB?=
 =?us-ascii?Q?yyvIMhXUlYfPnAiGMCVHcx0dX6aTphvwBfP2vOs75jJWJUjuVnpgd6PpU0gQ?=
 =?us-ascii?Q?tLix1zRj5/r9MfkiqZuQLTvdgb1omQCwlrsa3SRTFoL4pJALf7Yg5YHHgPW+?=
 =?us-ascii?Q?GjL91rGkMTLBVI5e2FjqnQJ2GxXZSI0FU/WONfFu2CaNDMmIcalWlrpCP/We?=
 =?us-ascii?Q?8qWuxE/pLYFnrUJUl7HSZWtbobFNqO4xQg6iZw3TZev3mKMk7pBeopVBb67w?=
 =?us-ascii?Q?X0bvZp5KQkSq7r6DtrpqBTJajqtp+JHzeYObUvXJp6WZ8AWxargKujmhvNaS?=
 =?us-ascii?Q?Fww1i+hM5PibogYZcyybynEzLN87amSXmZREc9x9fSahix+3xZivNJ8LeJaU?=
 =?us-ascii?Q?zvhrzrYtFQcYOmpCjg/s9gXjP9uHYMjpLQJZKDgOgw7rSzPJCjP5GC4l8WCB?=
 =?us-ascii?Q?A1/SVDmrsWsHz+KEUzGh0kNpClGy15Gvm1uyQmAUscKm7zw11i/A415ba0w1?=
 =?us-ascii?Q?ZuEH7MIyruQXzph7nBM9w+903nVvyxLUqwSCHoRY1qq/jtd9auCEPbn65dRX?=
 =?us-ascii?Q?fXUr9WDRgp9UqAamg36HPe5piletkXHJ8lWDIMbWku25/GlxCPIGfBofql80?=
 =?us-ascii?Q?B3g5tWdatGkyFDXTdiIojx2HB9jWCRbRaBuhF+wLkNHY8H4e+jZSIsa/7Yde?=
 =?us-ascii?Q?BYJ5Mnoxud3/mimIs2amxr1E1d16hKwxj0qMElux19FC8kckQ+EbPip2KEma?=
 =?us-ascii?Q?K5jZKxD4rNZQxTIskr2mCT5jrKlNRR4b4nAjQ8PTLxR90gMgLPetyUjWLDwY?=
 =?us-ascii?Q?YW22ENkQN5BYLUPHKO9U0tjzmD17S/ZSq3A93WxoYrUzbyRS2EMBUB/7TzHe?=
 =?us-ascii?Q?ZRvplbo5nqt0OlkLGZ6pBeIpFE9vDIeRe90mFnOeXpbdNcSZYYLDIWa6sijm?=
 =?us-ascii?Q?a3HI8fbWw3KdDXurkgNd/s4WvTofcrP2FqpNsdjn9DaswXx+h+vQaMzlgi2f?=
 =?us-ascii?Q?N5ewq/OOnZ0GwR9FS5UCNadmN3E5ZuZyuc0U3vgxFOVotcRCbOACTHZMR+Z5?=
 =?us-ascii?Q?mXLIyFNvnUoFtcNUG50nOrGg+QigDshMmikNepBDmH03s/mnswCjun8t1GPj?=
 =?us-ascii?Q?lDl7JGGUyJ36Joi/PlBkXi/MhhSKdjuz+/tC+xnBgPPf7MtTcYfovGMBT5im?=
 =?us-ascii?Q?4H1czqPyKLUFRgWCPIM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ed7fc5-6fc0-4af9-83db-08dd9253e9fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2025 19:25:26.1749 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 02RIixQyoqxL0zMIJL7rQaKZS7z09w8DNktzkzacSIvoJBcrZsxoSRalAuEWkQLv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7635
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

The series is
Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>

-----Original Message-----
From: Wu, David <David.Wu3@amd.com>
Sent: Tuesday, May 13, 2025 3:22 PM
To: amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.=
com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Leo <Leo.Liu@amd.c=
om>; Jiang, Sonny <Sonny.Jiang@amd.com>; Dong, Ruijing <Ruijing.Dong@amd.co=
m>; Limonciello, Mario <Mario.Limonciello@amd.com>
Subject: [PATCH v3 3/3] drm/amdgpu: read back register after written for VC=
N v5.0.0

V3: patch for VCN v5.0.0 only

Similar to the previous changes made for VCN v4.0.5, the addition of regist=
er read-back support in VCN v5.0.0 is intended to prevent potential race co=
nditions, even though such issues have not been observed yet.
This change ensures consistency across different VCN variants and helps avo=
id similar issues on newer or closely related GPUs. The overhead introduced=
 by this read-back is negligible.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v5_0_0.c
index 27dcc6f37a73..77c27a317e4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -794,6 +794,10 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_vcn=
_inst *vinst,
                ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
                VCN_RB1_DB_CTRL__EN_MASK);

+       /* Keeping one read-back to ensure all register writes are done, ot=
herwise
+        * it may introduce race conditions */
+       RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
+
        return 0;
 }

--
2.34.1

