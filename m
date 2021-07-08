Return-Path: <SRS0=sNMb=MA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79B8C07E96
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jul 2021 13:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D894616E8
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jul 2021 13:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D894616E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28B9389E1B;
	Thu,  8 Jul 2021 13:33:37 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DCE089DF9
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jul 2021 13:33:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kELIh1kZzbJKGfPqEttvA4dt3WN3oIwg991Eu1nkUc5Nnx6aMLx9D0u5iaFjnOxdB6HIXYE+bPLyp6DG0qNW7SJs/WBQHHGdf0HQNDKkqV4oQYzFH5isM0k8a5ErgsdcKg9m8czUFOuX5vgCiwFwGEGJDQ43A1Dkf3NpLExlIqmSZmwiRMgRYHEjKTcCR4ZwLi8pp18EWf8YwIkyli5wZSE3f3jZNHuqexBN0G5AOFCKjNO5fKYSfuBUs1asz26iVlc31LlrYiN2Xpt0rsIv+DBOL0K5mIO/C6LmulICv2is731IjFF0ZAlyv8n8SYw1ZDDJGFzHhrwtQ8fJxk6wBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtMN2desXjVYUVJ6e/UWH73RbQTrSWoShGfbxtA42t4=;
 b=M81kbxhLTTFzObkLnuZX1ThB+sESz2wbN4Tu8QMCoVE8fE7b8AE7pT2Y0XsiKbFWzVzn/jxEUm5FZm4z0POs7dO9lAWVZxj08H/ozbgpgEOwEAUoziI0T9rriqGl7HbFFiSQjW6nJK+Ldcs1rT1/IPa5AzExIfiEqVwtEx9fW32388veVljT1OSufKUO1veKAuie9+xcr+XL/OoCe2iZ2oKHMbE/2M9K1XZTEiBlFhsR0YucfjQ3DvEYQUAuHxP+5RbZwxhOhvWV15PxZU1Cag/JtCpTg9ZVUYvS60YaDiGTEq31ihpoU/53vGlNKrVHophQbthyWp+j9SQG5M1kVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtMN2desXjVYUVJ6e/UWH73RbQTrSWoShGfbxtA42t4=;
 b=SbJp/6Pl1nCmcv9zrZ/CW6hxFYTAaqnYjYFY0wHmy0bJcXPVoB8xJns8fEF5Xs2ce+rWwvDaGKuiXeagD/orgto1SCEmtP120r09rYVgafUMEwUihX8EO2nn66N1aaSS2gvZS32j6RDCDiDDtNT7gYSLnDLVjoDi1KIteTFl2hg=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB2502.namprd12.prod.outlook.com (2603:10b6:903:da::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.31; Thu, 8 Jul
 2021 13:33:34 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::2cb6:690b:e6a0:d008]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::2cb6:690b:e6a0:d008%3]) with mapi id 15.20.4308.021; Thu, 8 Jul 2021
 13:33:34 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Sun, Roy" <Roy.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: return error type when programing registers
 fails
Thread-Topic: [PATCH] drm/amdgpu: return error type when programing registers
 fails
Thread-Index: AQHXc+L07bJhil2VWECEnXy1cQNWrKs5EkUA
Date: Thu, 8 Jul 2021 13:33:34 +0000
Message-ID: <CY4PR12MB12879FBFD8B7D772E206C174F1199@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210708102046.16880-1-Roy.Sun@amd.com>
In-Reply-To: <20210708102046.16880-1-Roy.Sun@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-08T13:33:31Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=e31ec47d-46bc-46aa-bdf3-430a5d299674;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 065d6a33-7ef2-4a88-6d83-08d94214fc10
x-ms-traffictypediagnostic: CY4PR1201MB2502:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB250215DDA111FE5767BB6102F1199@CY4PR1201MB2502.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jc0TRzJe7SO5rgLE5EKX+DIAjr6Vz+uFM+/jyXmEfBUw1CtvESCDw95Da4PazBbtMKBb6/awvh3kQGTUE1VWkdb8GL8OeSUaHxvbXyuszTt3lc32aFOzlFGgxQ8yKBEkKFdcz+XEgVrsYTCUXTZnnn5V+9x7OsUnypCoLUuy5SLTQe75VpkmlWAc0IbubBK38/QGcDXBH1aVfz8MSkOSLXMmx6L2hvpGsx4rNRpOBFrXvVHnqxN9aBi5yVt21obwXE/O4q4KcfWG26w2B4hdVFDew6u5aMiRtz+UZ9ZXnfrnMcRD/O2bX82RWAxEP7JKCXtpaiz5b3f4DHuNVxhxSSOYMv3MEQRdQ2tJp25v/8hfO/QZsoJCQ7mQyK6JxKxjyuPrFl4kgA+LEL5oh/nLsfCL6R7i9mX97O5ncz5rglvOtJMP+vLyEE2/+nEusWwXraPrxjygKTdUw42jvBwwWe3HX+9XUmyBXnhuCJX6dDpp2ITIuNur8c7HPmPLRgSts7TqAD0XhoMPW4d03H1KXTRv4YUdKn0HYxEDD9tEG66ER7MB9Vgg0pVEd+C89ZFUOtkUBjLywSXUailkNeYSuQckocO/FX4mx3ywSAaQ/CGM33synOe6dPm41EmpUesR2VozyAVN0l0X5q53+8TVqw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(66556008)(478600001)(71200400001)(64756008)(53546011)(66476007)(9686003)(316002)(38100700002)(33656002)(966005)(26005)(66946007)(66446008)(6506007)(186003)(5660300002)(2906002)(8676002)(110136005)(52536014)(45080400002)(83380400001)(122000001)(7696005)(4326008)(76116006)(86362001)(8936002)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mZlDPiHiN+sjSxYrVIbnHg3r19Eaddu8QglEI3Y1FGhfe39esNaN4AQiwmbo?=
 =?us-ascii?Q?W5XZWuQLTZxbj31DxMaA+BXp7KH+pcnAdZSXYyFjDB/stzyPLtaq315DgZ+x?=
 =?us-ascii?Q?Zw2+wwjW2mEgxQ9/CDN//hb2U97eC0WR4GgTD2slKpma7LTUQtn/NkUBnDJp?=
 =?us-ascii?Q?GT5TX1UXuJF/berMBBRCz+I0SmKR12is3b4SyFodU4Wk1mFLTIydRzXymJlf?=
 =?us-ascii?Q?FyFiWDfmWwB7037xb/xD14PNTB/gKzUS20fcxjnlsUaKArFMQ9ks7ug5vtMS?=
 =?us-ascii?Q?QKyxCnuMCpfb5hrIa7YQRtkU76fOYZCuozXiX2CEHrkmkNlOqWpdOianI+FE?=
 =?us-ascii?Q?24lVXVJwZbjOWEpYbIMKYLDDu0X3ql2uMLesl+aX8zQUFTzCL28Whr5lLZb3?=
 =?us-ascii?Q?yFox8X2c25FfBbkPTsEntoeatpc8uNguNj81c99DiZHrSU2H6Wf/Xfeh60xr?=
 =?us-ascii?Q?9areHI6kC/Digx0OZrZ48E4sAM6d9gl90Uud3jOHLt9anrMuRoB/k6zwOFNO?=
 =?us-ascii?Q?roPIUFKET71ebeY3h+Ax+STYugKgCbg8lBecUCmtnBV/zS8myUvSvyg2I68K?=
 =?us-ascii?Q?qZ1A4mBx3x5d2tqVuG6gdv+g80RIOH73/iPqHJid2euJzoddRPFUZlm7Qu/L?=
 =?us-ascii?Q?hzPeGh4DDYMbNsccHPTbw6r2Biu2ENkZLzoxctyRYS8ehS1NKkdhecPZ59C6?=
 =?us-ascii?Q?Wm+jFsZJCAuabKrl9Z9cxrznoX9WGnTgFPtShuj22UD1F91L41oyRTuOyFmc?=
 =?us-ascii?Q?oCCes+70rY3REPPU5ewERbSXaS4ppAnt3HHkWKVEjOKBLa2ZybDkRWOXX9gF?=
 =?us-ascii?Q?jKokmsTz8yoMJiOmPgKDWJwRoYOtVBQn+S0fNJfTBQ39/Hw8U6OCBD+E++j8?=
 =?us-ascii?Q?oKe90r+oC+KFZqEwdTloziZvFQ2WYZoP0sX50oD9LTMEK41r5PDEIPcAawOG?=
 =?us-ascii?Q?k2J4GlEQNDYs6ch9ZvqiVQMsMU0fQIC+VhL/8I7xG3IlCnFo2glpT/bItesr?=
 =?us-ascii?Q?iziOKIpojPvgKdHMoH0xO26EKiTH0ASbXCxeXW4kuDitQWRzhrwy3opiwYw3?=
 =?us-ascii?Q?kd0sRaxpTfALQ4LnCX6XiaNnjoBRAIzI6NurWT8UHotMSewAFE6K7G1kRHnL?=
 =?us-ascii?Q?xrukKd0mty6CoRp/zWHJbooZUaazD2FFOoAoK8KGAAv9tumM5je+z2xHpdZH?=
 =?us-ascii?Q?lZALswBmSWk4gFv8680Jc1A5Nd3Dli3t9MbG2IRecxzXUmv1HBounOtu/7oI?=
 =?us-ascii?Q?KylzHeRtkPYyX5LbdxrgaLX3WLBizyMWvCSCG8m9GERz55dko5KXFHxhpbeg?=
 =?us-ascii?Q?o6mHj2E7rEYtQl+/dlxptu+x?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 065d6a33-7ef2-4a88-6d83-08d94214fc10
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2021 13:33:34.3940 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7glZ9leNe8ZAtx+6Wkn8EjaJKjwpM85eSQayVSI6cYXv13tghpImL1Ud0lBYT04yscMomo9cgpnMvwMkfMMDRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2502
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
Cc: "Sun, Roy" <Roy.Sun@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

+			if (tmp & INTERFACE_NOT_ENABLED_FLAG)
+				error_type = RLCG_INTERFACE_NOT_ENABLED;
+			if (tmp & WRONG_OPERATION_TYPE_FLAG)
+				error_type = RLCG_WRONG_OPERATION_TYPE;
+			if (tmp & NOT_IN_RANGE_FLAG)
+				error_type = RLCG_NOT_IN_RANGE;

Is it possbile that in current code logic, when tmp = INTERFACE_NOT_ENABLED_FLAG | WRONG_OPERATION_TYPE_FLAG | NOT_IN_RANGE_FLAG, error_type will be overwritten twice, and set to RLCG_NOT_IN_RANGE finally.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Roy Sun
Sent: Thursday, July 8, 2021 6:21 PM
To: amd-gfx@lists.freedesktop.org
Cc: Sun, Roy <Roy.Sun@amd.com>
Subject: [PATCH] drm/amdgpu: return error type when programing registers fails

Signed-off-by: Roy Sun <Roy.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index bc4347a72301..2ec5b973a888 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -56,6 +56,15 @@
 #define GFX10_NUM_GFX_RINGS_Sienna_Cichlid	1
 #define GFX10_MEC_HPD_SIZE	2048
 
+#define INTERFACE_NOT_ENABLED_FLAG	0x4000000
+#define WRONG_OPERATION_TYPE_FLAG	0x2000000
+#define NOT_IN_RANGE_FLAG	0x1000000
+
+#define RLCG_UNKNOWN_TYPE	0
+#define RLCG_INTERFACE_NOT_ENABLED	1
+#define RLCG_WRONG_OPERATION_TYPE	2
+#define RLCG_NOT_IN_RANGE	3
+
 #define F32_CE_PROGRAM_RAM_SIZE		65536
 #define RLCG_UCODE_LOADING_START_ADDRESS	0x00002000L
 
@@ -1533,8 +1542,17 @@ static u32 gfx_v10_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32 v, uint32
 			udelay(10);
 		}
 
-		if (i >= retries)
-			pr_err("timeout: rlcg program reg:0x%05x failed !\n", offset);
+		if (i >= retries) {
+			u32 error_type = RLCG_UNKNOWN_TYPE;
+
+			if (tmp & INTERFACE_NOT_ENABLED_FLAG)
+				error_type = RLCG_INTERFACE_NOT_ENABLED;
+			if (tmp & WRONG_OPERATION_TYPE_FLAG)
+				error_type = RLCG_WRONG_OPERATION_TYPE;
+			if (tmp & NOT_IN_RANGE_FLAG)
+				error_type = RLCG_NOT_IN_RANGE;
+			pr_err("timeout: rlcg program reg:0x%05x failed! Error type: %d.\n", offset, error_type);
+		}
 	}
 
 	ret = readl(scratch_reg0);
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C99ca80d6566d4a09dabe08d941fa1578%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637613364637870490%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=FVx31FaVzTZ30a3IJi4YM1IMu%2BqKGxP0bmU5qzGVh5E%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
