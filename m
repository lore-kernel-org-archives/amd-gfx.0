Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24914C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 03:49:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9720D10E9EE;
	Tue, 14 Dec 2021 03:49:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFCB910E9EE
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 03:49:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjJCuyjf1gjB7+pvrc0w7L4jPoITTVGyzpCPcKu9lf8yYNFXe7L99UDW3aO7CMUVPHkoKCcnQ2BL8WYhZIIPiOrOGEQQLZ2oYXT/pe17zvcpAfB1QUJ9m1IZmN9pmhTbVd8/LsQ1Uiij4/Pr+Fp+Cx0JOkWVm7P0s8GcM3DWhGdpWhki//CUOmMfk6K46E7q4GVghuiVwOeJ/Y0yWC0KvDLaHHb3bCbPWwdJz/sN9sSMGSvlf6a9oJBqgWk4Oo8W/h/Ot2WT/chHKfRC0e+f1IRSJCpekrfCQQV6l3UbiCjxYkv+ysG/4kZjfcMfQGQoWwXKhgGjLeUfO9ltMr5+5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGf0Vubf3Zphv8fTIZPpz/1N2BCm7juKipWD4ASMjd8=;
 b=TGxdeX446Ui2Dp8mEdiJiKXNzNhmjr5Pfqkzl6U0yeA7CreK310HFjDBcq4VVAT7zmrDyzDHf2Izltc/+onhlLdCi7yKRuuuaXLIHs4pqAS1nxngGoIvyaAJEzRudQB0IlZRPYXrqrEMBrxoCCf97shwJY1LE47fRrXi61t+ChSZwNV/Qh0doI89kzMbv1A1ukXMUJYtlYwdfFBlH3JQRKc9mTR4xXnAkPqeksnJy78D5KRt2bv2OlgTutae2U5J2BgMDCJ8kiJfx0mV5+oE4weZGF5Qunt6URJOuxY+sTHvBnRz4tXqV1Tqg5H2/zIWNUK/VXTbmCD9ZnDCi2Ldug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGf0Vubf3Zphv8fTIZPpz/1N2BCm7juKipWD4ASMjd8=;
 b=LoGFfCTouSBhrexnZ47C735nd96o9Gk9Rib/3+lZqXaOF7xDBI8CqEjfmB8YJtSekejQ+0JIZ0itswYyer2DIhaZD4bsbad5NKj/IBGjskiKg5BGZ19yl6QK2Miouw/xWLVuF3/E80ELzcdH7QhwMxmYU2qUyWsw6ZhlP76sOHI=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB3369.namprd12.prod.outlook.com (2603:10b6:5:117::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.14; Tue, 14 Dec 2021 03:49:12 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e%5]) with mapi id 15.20.4778.017; Tue, 14 Dec 2021
 03:49:12 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: correct the wrong cached state for GMC on
 PICASSO
Thread-Topic: [PATCH] drm/amdgpu: correct the wrong cached state for GMC on
 PICASSO
Thread-Index: AQHX8IrNGdbxSjP5x02+PrfWIt474awxWfpg
Date: Tue, 14 Dec 2021 03:49:12 +0000
Message-ID: <DM5PR12MB24697AF2CCAAFDBACF6E43C7F1759@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211214013423.801735-1-evan.quan@amd.com>
In-Reply-To: <20211214013423.801735-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-14T03:49:04Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=b6e49435-69b1-4ab1-8614-12eeec9f74a0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-14T03:49:09Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: ee394e4c-54a8-4f5a-b6b7-5f5b62877a6b
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0657ff3-8c58-4e88-5d0a-08d9beb4b0fc
x-ms-traffictypediagnostic: DM6PR12MB3369:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3369C690410A85AFBCA372B3F1759@DM6PR12MB3369.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NqdRTGFsazzfXxVUbHnmJ81WLnRb1gnGo7Uu061+NCrebbToVAef+hAd8/JJ5q9YIRhVEzFQvUKVeHZv6dydQWlShHpO+dbsRkzalFaKHwzJFN6/PIwrTzyfGD6NVvQXIwEP2v84btno0PaCStGFJR5DR7p6kjAflwYX/i7ip+1b7QKBYJHuYzl00wjlah0tl+beBXb/jVw7LzVM9ThbVhb/79wF48bHVtF84sOG3LrItYOewFXKvMlYwEJ77XapPVK1GsC8Z+8pKAHvtP14FYdbyvQirG/QCiPNosoWgkRUPTLqSScXUMIWc6LVmOtdyaEsLhYHu2CX1WwQXRBgatqyotC5LbjVyUJzjwxhTCKksIHst7UzO8MI8ZA0yG/n7tOFttXUDHZvDZLY+i24RcjbESBhQm5APMATh9ounL08Lan+UqQUkey6APIUbZT3pY2w8Rpf3g9IVEuUc5ajZgEN36FRxz8PZncM50eqvN8Tszh3950mnMl8PQLYfwqX/YJq1FvTwbMAX5fBRXxtGmee5L3+TifmF054Jgzlba0PTI5EdX1XSp1SIDpkfrU37ejzH3r/UKqN7ZY4f6yYYVRJqRIFwIzkcdCGxxVN8IHBWKzbQKcZE+OqUgYCXcP8serz4H7QEJLxFcIyOxILcHT+KnwpvlnqGN1dhQvsouZiTlifmGR4GUNtfJajhHQ6FF0P9Hz4FOAmMp9ImfGpXA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(9686003)(76116006)(38070700005)(110136005)(66446008)(64756008)(66946007)(316002)(122000001)(71200400001)(7696005)(66556008)(66476007)(5660300002)(55016003)(83380400001)(54906003)(52536014)(4326008)(26005)(86362001)(38100700002)(186003)(6506007)(53546011)(508600001)(33656002)(8676002)(2906002)(8936002)(45080400002)(966005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mlL0jAsmEP+tCujGQB/rr2WGLHfMmg8gog7KlOwA7+eVBT2Ep7QXYTjJqrpE?=
 =?us-ascii?Q?q/+iAcZmuGEabjsxu74FRuWDIUguZzcXIsow4m2dptDiN45hi2rhvFaeyeGH?=
 =?us-ascii?Q?3lLzWsIUIvX01FkpLM8q7pWhYzulgAs1rb8hXeNmWvf6kaVNlBMLTNAecSzJ?=
 =?us-ascii?Q?oO1EY0l4NUxFhwoNXSdj0k8Evz2zWZcGulLoI3Y+BUl7aBGTGeg4Wgvgzz/x?=
 =?us-ascii?Q?jkMEnNrUJ7c43metGwmHV7FXhVOI+gsPd5Z3jraVlA4MrySLZq09VDiwsovr?=
 =?us-ascii?Q?+tIBAmx1uGH4APBRtjCMWwBzIQgakCpdi0zwsB0ABBXQzUXGOWKDFCK4Vas8?=
 =?us-ascii?Q?w99MLMc4fVg8wjyRepSS959cYBWfLJCcgabelXiu+rN0vSW+TAZF9g0ZYqls?=
 =?us-ascii?Q?mntOfnYZ7Z5Zul9ry0PiH+BwGxKnpkBnwjAj9mkZKEoFBSgHNuCM4AYKI+oE?=
 =?us-ascii?Q?TTI1ZqMf8ZCmVVompprfKgRMbBLow9V6rjFjUYGckDJ6yYiAW/JeQt7GTz0R?=
 =?us-ascii?Q?yRAqYPtnGpyKe9BUmKtiER12GKenPYPH0sRBtLcxord+D/CNSavhed8J60Ni?=
 =?us-ascii?Q?nMKZU0C2iiH9rvuDi6F0ir3mqmEEd151vZS8LMzxJpR9jI+KVZ6RgkiS0vu1?=
 =?us-ascii?Q?LS0Ql52d4fQ8HqeOMLyFRDMp9qqP792R+8eK5nIOJ10ibouzchbvzpM+pWrn?=
 =?us-ascii?Q?yTc8ScCiR3mjv+hhOOiqreEXY7ApxN5Ggd3MayHelGF+KMM3O4DIKPzFj0Xn?=
 =?us-ascii?Q?Snjci0q/gySbIwcvTqdUKH7GjyJQPGgWm4AuLdAaQe8xARde2CxhcdqMGYNt?=
 =?us-ascii?Q?pN1P8OKqkJQMxgN2ric0D6VIvgA20mfLBJklC8Z+mjlC6DLnhIt5CgKA9bAH?=
 =?us-ascii?Q?S2/SMr7lrIiZ1dfz5ZzyG5jMcMmcq8d/8O2nO07e7y7pmrqZadK6h0rexhid?=
 =?us-ascii?Q?M3BMgIcKUgRz3XvpdoFm6lXauwZ4PtscRGSlw+S6gmnnJJX+22KLGKK2sRVN?=
 =?us-ascii?Q?63xKjHxfasnDNa0rAH0RvlptjcpZEWfbfqpYvvJAl+GKXWQYDpxe5sny2JLZ?=
 =?us-ascii?Q?Fx9DiwT0CPCGEXh062ONKqxdQqdrodg/lL99mp4fMdANwIUEu6iR2h5YOseA?=
 =?us-ascii?Q?XBuqY0RhYFqGL2VMuxP+Q1A4EF/r7rwszl482IMGw6VqF4UclVoShUkNEvBF?=
 =?us-ascii?Q?1dK9wLufDzU809nuvPz3Z2qagfDEDQ4Eab+bm6y5bDW0hv53cGkLKKlsDKWb?=
 =?us-ascii?Q?iezztn33gGjw4woXNG8bRa1XLygW3Vqvact0N2BdBrP4x5NblqIkO+Hv1Wmd?=
 =?us-ascii?Q?/1RAmEXk34zdWrVWrgmbecomqwjH94avTI21pfbavVkmzplJsGtdLxrErhSw?=
 =?us-ascii?Q?8VPW09nLYJyXiLJVo+kWNX05oMuOG98VWC0TD9ZJj+D/I0RqZdOOr/a0S0v2?=
 =?us-ascii?Q?HFOws2LB1NzzGaBYURIE+8AiO/ioXMXE2NP6DuIGeEtGbgKV0hRqXk6ZhRNv?=
 =?us-ascii?Q?o/6gCj1oqa73Hi5BvP1CCna09UTDAsRSq41MagevCo+gEYvyazyaNbu5fsXs?=
 =?us-ascii?Q?OYkCGgKX6Vjd4ROOdrNZ0wsKTZW89nTUHyVgs0Yl6JdRDk0r2yMqYNXzEQqe?=
 =?us-ascii?Q?CAaDQd5EyMj2EYJ8Nlzz8+k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0657ff3-8c58-4e88-5d0a-08d9beb4b0fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 03:49:12.1261 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FNvRgvg77pyk6hWmMDAmuQCLTAcWlrCa5g/cVqSu7zcK7oRoaspnYctY3agupSpKxkZvYwRr7V6Q0VAq/jTKJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3369
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Acked-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Qua=
n
Sent: Tuesday, December 14, 2021 9:34 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>; Limonciello, Mario <Mario.Limonciello@amd.com>
Subject: [PATCH] drm/amdgpu: correct the wrong cached state for GMC on PICA=
SSO

Pair the operations did in GMC ->hw_init and ->hw_fini. That can help to ma=
intain correct cached state for GMC and avoid unintention gate operation dr=
opping due to wrong cached state.

BUG: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi=
tlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1828&amp;data=3D04%7C01%7Cg=
uchun.chen%40amd.com%7C42b00d7e1c4e44c0762908d9bea1ef53%7C3dd8961fe4884e608=
e11a82d994e183d%7C0%7C0%7C637750424983319967%7CUnknown%7CTWFpbGZsb3d8eyJWIj=
oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sda=
ta=3DVgBDAbcKN%2FqUz8iBQby9YP8PsG2y93VlnDVhXVaGNBo%3D&amp;reserved=3D0

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I9976672a64464b86bb45eed0c25c9599d3bb4c06
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c            | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c          | 8 ++++----
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 7 ++++++-
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index db2ec84f7237..c7492db3e189 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1809,6 +1809,14 @@ static int gmc_v9_0_hw_fini(void *handle)
 		return 0;
 	}
=20
+	/*
+	 * Pair the operations did in gmc_v9_0_hw_init and thus maintain
+	 * a correct cached state for GMC. Otherwise, the "gate" again
+	 * operation on S3 resuming will fail due to wrong cached state.
+	 */
+	if (adev->mmhub.funcs->update_power_gating)
+		adev->mmhub.funcs->update_power_gating(adev, false);
+
 	amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
 	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v1_0.c
index b3bede1dc41d..1da2ec692057 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -301,10 +301,10 @@ static void mmhub_v1_0_update_power_gating(struct amd=
gpu_device *adev,
 	if (amdgpu_sriov_vf(adev))
 		return;
=20
-	if (enable && adev->pg_flags & AMD_PG_SUPPORT_MMHUB) {
-		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GMC, true);
-
-	}
+	if (adev->pg_flags & AMD_PG_SUPPORT_MMHUB)
+		amdgpu_dpm_set_powergating_by_smu(adev,
+						  AMD_IP_BLOCK_TYPE_GMC,
+						  enable);
 }
=20
 static int mmhub_v1_0_gart_enable(struct amdgpu_device *adev) diff --git a=
/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/=
powerplay/amd_powerplay.c
index 3656a77baea4..9953a77cb987 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -1167,7 +1167,12 @@ static int pp_set_powergating_by_smu(void *handle,
 		pp_dpm_powergate_vce(handle, gate);
 		break;
 	case AMD_IP_BLOCK_TYPE_GMC:
-		pp_dpm_powergate_mmhub(handle);
+		/*
+		 * For now, this is only used on PICASSO.
+		 * And only "gate" operation is supported.
+		 */
+		if (gate)
+			pp_dpm_powergate_mmhub(handle);
 		break;
 	case AMD_IP_BLOCK_TYPE_GFX:
 		ret =3D pp_dpm_powergate_gfx(handle, gate);
--
2.29.0
