Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B9BCDB474
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Oct 2023 09:04:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 698E310E009;
	Tue, 17 Oct 2023 09:04:36 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BE4410E009
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 09:04:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hxsx2NWQ6m4EfOVGuZ81kiLzjGDzAaO5vP/kU7HgJeIEy8i1RVtpjo591mOf84aeYPQ/6BTRAJdzgC0FS6o/I1pq8LlMBKy8Cyhob4tFix2ZL6rwCsGLBhExnwWlIcuBDorELChTExfY/nF9aQ7DlKYuM42q0PZfA0TAC7kTBNOjKbtX5ZBR8CAUuApdptiJMSkNU3Q8zI8xjc3KiEnoQbXTq05/e4ltRe2N+w1u7CVRWkev7JPARKA0a/vkabYcX5a6ULm969LjG56uunqEdA6VFwmK30n9hrfz3Df7CH5xJOm73Qg6ZZKKUYd0N7O28CAg3vij8ufJey7YXeeAAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFk/eW5Kf8e/sM7oNzZ6BOEgDYYgXpxYtr2WmEb54sI=;
 b=KcIVE1/5vfx7+OfA90amZ8vTN9gAzBGJJ+Z4qxwgElLi9/Zfh6NslG7/okniQp8o8VZ8h7m2KBPHgC+xQq7o204rJ5k9nzPEIMy8PYmFDh3FvVYcw4Rx1j/S9KmH63KcZbH/2Bs4RhMdap/CcKUcn2EzbVK+ultbwvTKos7oyG1vnXL1qcsxA+EabMbwRtSVfLlwbMrlplgCemsBsNmbdUkxOXUWJUxG6WkG23qzsJcU8Jq7Hg2aZS6YEKXDijeV6z6mlJRuqMnBITFh7UdOiNQlpbhgK5jvsbikE4NcWOM/2+J6rQzsbXcl2VWBo3wQQUKGGlTc9RSsqJBw7Bv3ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFk/eW5Kf8e/sM7oNzZ6BOEgDYYgXpxYtr2WmEb54sI=;
 b=RdWm3DHb87ScfGAeMI5TqisO2cxeSQWLwG0kxczXUnVFeKzPc6EHLO07AyeUxGUuvR2d0OsoQcMkPubPbvYZjugjSFtlyo3kes4O8mvcskaIsLQbknSA6HgzeGMau8f/670zxYv1M8fp2ax+cy4pKns4dKw6N2jKkmyEInftwAU=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SJ0PR12MB7006.namprd12.prod.outlook.com (2603:10b6:a03:486::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Tue, 17 Oct
 2023 09:04:30 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::901b:d130:b9df:f9cd]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::901b:d130:b9df:f9cd%5]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 09:04:30 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: update to the latest GC 11.5 headers
Thread-Topic: [PATCH] drm/amdgpu: update to the latest GC 11.5 headers
Thread-Index: AQHaAFw6X27fL/yfoEW9xW0//S5CbrBNsNcA
Date: Tue, 17 Oct 2023 09:04:30 +0000
Message-ID: <CY5PR12MB63697B34E45B21F02E1FAF36C1D6A@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20231016181124.2235387-1-alexander.deucher@amd.com>
In-Reply-To: <20231016181124.2235387-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b01a5076-128b-4876-a655-6eaf299e6c76;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-17T09:03:23Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|SJ0PR12MB7006:EE_
x-ms-office365-filtering-correlation-id: 631f754e-0926-4bfa-95e9-08dbcef01282
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YFA7in1JjLcHurgj/8ZfwKjGKKVKgvUqgPYJaxJyzPfkZRm+rLVLEBOqQ3QDAXll1V4NxuVnpSoTcMSr0s+6VrOmU8l6AFeY0bNDGcpY6BkE6Uqd4DzbEnb4k3kVPg8wMemOwrvkcL7zM73iWWBPHHw+fPStJROyp/VZfwnrnSK7pbh7JC5wQGTGczIPZxikj+i7C69GHZtYgMFXVcCnYURyng7BRPVoMJuaQJ7VzDZtdxKQNrqK0f8pBCyC50qzMsU10o/PF6E4UqbVBHDEwWHKW/ZAH8sMAlKEaHWMrIEdBODr4mtPhOAimxilUlbXYetP/7F0GnDX1uYKmYffJ0Vlu2xtsx9JnnhMsQ7CfxnbXbCbSEQr3UcblarP5vs01WjP+VTanA8cI7No/3juQll7IziuGjuaw9OJCTfpgpIsAr1m/goeA7n8XlkeMGBvaFcbIJ4TDsqBi9VkcmwZ0oeOQOBd9hIoj/rJs/txhYVlm3Oqsjl++FJQwrdE2w7ATPbCA5W0XGlItRiGDjpLp6OufvMl2QYRvi1GG9meWjRmVrNCJc73MFW2FOYze2vnQwk9A8PF+dgy7wANpLBFFgoVzJUkj7EuhBv0mF6HdW2pFLoNxC1p38BdMZBBs6I4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(136003)(346002)(39860400002)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(55016003)(478600001)(110136005)(64756008)(76116006)(66556008)(66946007)(66446008)(71200400001)(66476007)(83380400001)(86362001)(38100700002)(9686003)(316002)(6506007)(53546011)(26005)(7696005)(5660300002)(38070700005)(41300700001)(8936002)(122000001)(30864003)(52536014)(33656002)(15650500001)(2906002)(4326008)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a9Xs6sbiPn7xNxvUYWEx/zNkqlQOjGMgwtT6Cw/kD8Yu7G2OFIfuGLHvbVhA?=
 =?us-ascii?Q?iuL2DjWa5My77I+0t21WQ63Au5H7FMLsl9kpGx/XrgNPpWpxYNpWr0CVZ2Pj?=
 =?us-ascii?Q?lGMqk7RVNLCLMphdKNvKhIAv/EFhL+rmK6J/nJ5Yup+eYxBL2vN8NtnOz+7H?=
 =?us-ascii?Q?UZFszFS0+TPTXfZ6WTikwuYQQ3EixUVweKIJa8diC5DBoSOSbikWX/ERR/Tz?=
 =?us-ascii?Q?wJJNTIX9PDYV248IGkEpBwJ4GFnoDxnoNFFEqOqxO8qhWwYYkIM8N9sO5rtJ?=
 =?us-ascii?Q?+ilmgl3hySZD50QdyJXSmqk4M4+GS9AlQ4RU1HNvuV5nZCQfW9Y13bekrM42?=
 =?us-ascii?Q?9C2cTaTcZoraAsUdhb7zJxolA8qwQaU4bV1t7z/zwtYWPwQyCB5oQ84skuIf?=
 =?us-ascii?Q?20KnNnJBaOxpwLPBEPhTOmZSLEwbs+YcdEdCjPSN+kLR6WTQpgk+BFvsRntb?=
 =?us-ascii?Q?ISMt4meYv/ooYqj6wQ1OSfGu3OeBjK/snsltWg35sF0pNF4sTIFKnAqtBfMC?=
 =?us-ascii?Q?hXESn/g5k+NZVr9Vwl8YOjcqoBfb+h/nnDSY4/qCk8LP6TO7mQcBz/PeZw1s?=
 =?us-ascii?Q?cTQS8ZbC9657tLgdPOKeZIlByALY7sCk6CsipelosTG1qChAzA2XiCFMbw+I?=
 =?us-ascii?Q?rG0kb7iXFIyYqdrBL5Iho8aaYFw6Y0E6R7cL5S/BaxICYzv7AI21XhjlQQ+M?=
 =?us-ascii?Q?3ZdFQ8cv/tlwkuaRbzBD/h8XKRT2moedRR+3ZekYwV+Oy910NRy6VwMH75Ii?=
 =?us-ascii?Q?sFvcxHv4TdLG9scSBk/Ap8V+DYgCDNZ8uAboW+Gp4ate+kMtPw9UIBauIUU9?=
 =?us-ascii?Q?WHgLW3HdkrWJyF689R6x/7cUK36KfoqnP7nxhYiWbQ8b1Ry+V5FdFgOqjVqp?=
 =?us-ascii?Q?OLz/zhSPTI9opdr0otDzNpOBPDlz1VMjUwtAe8rAwiqj4YAJpvZZR1U2bvch?=
 =?us-ascii?Q?XvGw7XJhDJ85fGaHG2QLjyjYKddHBVnSjcJGvi32K6AIBAO5YvXLdvufjZWz?=
 =?us-ascii?Q?dzNX68Hvhlw1+EecFWFzu2suK8cEB6yAN9AIk1JosIZxRsCwNMdzQpr0GVzI?=
 =?us-ascii?Q?CHLCWUxHp4x9wDjeT44/YWqOg9eiiQu5Bc5GWrFh33UDXhHafRGlIQ5WXotS?=
 =?us-ascii?Q?BQujWEiWARDdLkO+cWuAP0jxOYxmhg0LGwUvtqEUlVg1615aRk94HQXMn5l6?=
 =?us-ascii?Q?8thFNc/7yUq65yCmnghOYCqs50Z1YsgwtTH7fdwA5MtwUVKHJaHmqOjUBS3a?=
 =?us-ascii?Q?1bM16nSv9UNKteVqSMxqzxDQopep2MaXaq3nn4J0dNR9Ec7NWAvwUjMAaZug?=
 =?us-ascii?Q?E8YbuGVXD/tSB1DgF1ixkFNL76jXePtxpbpJBp0bTqS26YIZJQd95mcUamfr?=
 =?us-ascii?Q?pyzsEHA+roG43KZ4VTSYXW2BBaLiLWrJP82uDxJxe1If/SDScdvAI5EhJT0X?=
 =?us-ascii?Q?YUnGN6G2vvXT4jwWnewpZUQRIi0dHkZ3LH4xeVEw5mIvh+qrl77bcmQJ1fa8?=
 =?us-ascii?Q?OaRUbnNQn3QqSS56bn+Y+5ctPh66CpYvtqp3kO6T4nxyKGNUXvbJsWW/sGOo?=
 =?us-ascii?Q?l/0Ef91+Wtx/G7nFuMg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 631f754e-0926-4bfa-95e9-08dbcef01282
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 09:04:30.0947 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 252vf+7GVMJ6JLdw/ELYSB6QgfOiE8PhzSnhZA8YEyKiZGwV2/xrvaWzOn4aYpIf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7006
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

This patch is:

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Tuesday, October 17, 2023 2:11 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: update to the latest GC 11.5 headers

Add some additional bitfields.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../include/asic_reg/gc/gc_11_5_0_sh_mask.h   | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_5_0_sh_mask.h b/=
drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_5_0_sh_mask.h
index 3404bf10428d..f10e5d1f592b 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_5_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_5_0_sh_mask.h
@@ -19227,6 +19227,9 @@
 #define CB_COLOR0_FDCC_CONTROL__FDCC_ENABLE__SHIFT                        =
                                    0x16
 #define CB_COLOR0_FDCC_CONTROL__DCC_COMPRESS_DISABLE__SHIFT               =
                                    0x17
 #define CB_COLOR0_FDCC_CONTROL__FRAGMENT_COMPRESS_DISABLE__SHIFT          =
                                    0x18
+#define CB_COLOR0_FDCC_CONTROL__DISABLE_OVERRIDE_INCONSISTENT_KEYS__SHIFT =
                                    0x19
+#define CB_COLOR0_FDCC_CONTROL__ENABLE_MAX_COMP_FRAG_OVERRIDE__SHIFT      =
                                    0x1a
+#define CB_COLOR0_FDCC_CONTROL__MAX_COMP_FRAGS__SHIFT                     =
                                    0x1b
 #define CB_COLOR0_FDCC_CONTROL__SAMPLE_MASK_TRACKER_DISABLE_MASK          =
                                    0x00000001L
 #define CB_COLOR0_FDCC_CONTROL__SAMPLE_MASK_TRACKER_FEA_FORCE_MASK        =
                                    0x00000002L
 #define CB_COLOR0_FDCC_CONTROL__MAX_UNCOMPRESSED_BLOCK_SIZE_MASK          =
                                    0x0000000CL
@@ -19241,6 +19244,9 @@
 #define CB_COLOR0_FDCC_CONTROL__FDCC_ENABLE_MASK                          =
                                    0x00400000L
 #define CB_COLOR0_FDCC_CONTROL__DCC_COMPRESS_DISABLE_MASK                 =
                                    0x00800000L
 #define CB_COLOR0_FDCC_CONTROL__FRAGMENT_COMPRESS_DISABLE_MASK            =
                                    0x01000000L
+#define CB_COLOR0_FDCC_CONTROL__DISABLE_OVERRIDE_INCONSISTENT_KEYS_MASK   =
                                    0x02000000L
+#define CB_COLOR0_FDCC_CONTROL__ENABLE_MAX_COMP_FRAG_OVERRIDE_MASK        =
                                    0x04000000L
+#define CB_COLOR0_FDCC_CONTROL__MAX_COMP_FRAGS_MASK                       =
                                    0x38000000L
 //CB_COLOR0_DCC_BASE
 #define CB_COLOR0_DCC_BASE__BASE_256B__SHIFT                              =
                                    0x0
 #define CB_COLOR0_DCC_BASE__BASE_256B_MASK                                =
                                    0xFFFFFFFFL
@@ -19301,6 +19307,9 @@
 #define CB_COLOR1_FDCC_CONTROL__FDCC_ENABLE__SHIFT                        =
                                    0x16
 #define CB_COLOR1_FDCC_CONTROL__DCC_COMPRESS_DISABLE__SHIFT               =
                                    0x17
 #define CB_COLOR1_FDCC_CONTROL__FRAGMENT_COMPRESS_DISABLE__SHIFT          =
                                    0x18
+#define CB_COLOR1_FDCC_CONTROL__DISABLE_OVERRIDE_INCONSISTENT_KEYS__SHIFT =
                                    0x19
+#define CB_COLOR1_FDCC_CONTROL__ENABLE_MAX_COMP_FRAG_OVERRIDE__SHIFT      =
                                    0x1a
+#define CB_COLOR1_FDCC_CONTROL__MAX_COMP_FRAGS__SHIFT                     =
                                    0x1b
 #define CB_COLOR1_FDCC_CONTROL__SAMPLE_MASK_TRACKER_DISABLE_MASK          =
                                    0x00000001L
 #define CB_COLOR1_FDCC_CONTROL__SAMPLE_MASK_TRACKER_FEA_FORCE_MASK        =
                                    0x00000002L
 #define CB_COLOR1_FDCC_CONTROL__MAX_UNCOMPRESSED_BLOCK_SIZE_MASK          =
                                    0x0000000CL
@@ -19315,6 +19324,9 @@
 #define CB_COLOR1_FDCC_CONTROL__FDCC_ENABLE_MASK                          =
                                    0x00400000L
 #define CB_COLOR1_FDCC_CONTROL__DCC_COMPRESS_DISABLE_MASK                 =
                                    0x00800000L
 #define CB_COLOR1_FDCC_CONTROL__FRAGMENT_COMPRESS_DISABLE_MASK            =
                                    0x01000000L
+#define CB_COLOR1_FDCC_CONTROL__DISABLE_OVERRIDE_INCONSISTENT_KEYS_MASK   =
                                    0x02000000L
+#define CB_COLOR1_FDCC_CONTROL__ENABLE_MAX_COMP_FRAG_OVERRIDE_MASK        =
                                    0x04000000L
+#define CB_COLOR1_FDCC_CONTROL__MAX_COMP_FRAGS_MASK                       =
                                    0x38000000L
 //CB_COLOR1_DCC_BASE
 #define CB_COLOR1_DCC_BASE__BASE_256B__SHIFT                              =
                                    0x0
 #define CB_COLOR1_DCC_BASE__BASE_256B_MASK                                =
                                    0xFFFFFFFFL
@@ -19375,6 +19387,9 @@
 #define CB_COLOR2_FDCC_CONTROL__FDCC_ENABLE__SHIFT                        =
                                    0x16
 #define CB_COLOR2_FDCC_CONTROL__DCC_COMPRESS_DISABLE__SHIFT               =
                                    0x17
 #define CB_COLOR2_FDCC_CONTROL__FRAGMENT_COMPRESS_DISABLE__SHIFT          =
                                    0x18
+#define CB_COLOR2_FDCC_CONTROL__DISABLE_OVERRIDE_INCONSISTENT_KEYS__SHIFT =
                                    0x19
+#define CB_COLOR2_FDCC_CONTROL__ENABLE_MAX_COMP_FRAG_OVERRIDE__SHIFT      =
                                    0x1a
+#define CB_COLOR2_FDCC_CONTROL__MAX_COMP_FRAGS__SHIFT                     =
                                    0x1b
 #define CB_COLOR2_FDCC_CONTROL__SAMPLE_MASK_TRACKER_DISABLE_MASK          =
                                    0x00000001L
 #define CB_COLOR2_FDCC_CONTROL__SAMPLE_MASK_TRACKER_FEA_FORCE_MASK        =
                                    0x00000002L
 #define CB_COLOR2_FDCC_CONTROL__MAX_UNCOMPRESSED_BLOCK_SIZE_MASK          =
                                    0x0000000CL
@@ -19389,6 +19404,9 @@
 #define CB_COLOR2_FDCC_CONTROL__FDCC_ENABLE_MASK                          =
                                    0x00400000L
 #define CB_COLOR2_FDCC_CONTROL__DCC_COMPRESS_DISABLE_MASK                 =
                                    0x00800000L
 #define CB_COLOR2_FDCC_CONTROL__FRAGMENT_COMPRESS_DISABLE_MASK            =
                                    0x01000000L
+#define CB_COLOR2_FDCC_CONTROL__DISABLE_OVERRIDE_INCONSISTENT_KEYS_MASK   =
                                    0x02000000L
+#define CB_COLOR2_FDCC_CONTROL__ENABLE_MAX_COMP_FRAG_OVERRIDE_MASK        =
                                    0x04000000L
+#define CB_COLOR2_FDCC_CONTROL__MAX_COMP_FRAGS_MASK                       =
                                    0x38000000L
 //CB_COLOR2_DCC_BASE
 #define CB_COLOR2_DCC_BASE__BASE_256B__SHIFT                              =
                                    0x0
 #define CB_COLOR2_DCC_BASE__BASE_256B_MASK                                =
                                    0xFFFFFFFFL
@@ -19449,6 +19467,9 @@
 #define CB_COLOR3_FDCC_CONTROL__FDCC_ENABLE__SHIFT                        =
                                    0x16
 #define CB_COLOR3_FDCC_CONTROL__DCC_COMPRESS_DISABLE__SHIFT               =
                                    0x17
 #define CB_COLOR3_FDCC_CONTROL__FRAGMENT_COMPRESS_DISABLE__SHIFT          =
                                    0x18
+#define CB_COLOR3_FDCC_CONTROL__DISABLE_OVERRIDE_INCONSISTENT_KEYS__SHIFT =
                                    0x19
+#define CB_COLOR3_FDCC_CONTROL__ENABLE_MAX_COMP_FRAG_OVERRIDE__SHIFT      =
                                    0x1a
+#define CB_COLOR3_FDCC_CONTROL__MAX_COMP_FRAGS__SHIFT                     =
                                    0x1b
 #define CB_COLOR3_FDCC_CONTROL__SAMPLE_MASK_TRACKER_DISABLE_MASK          =
                                    0x00000001L
 #define CB_COLOR3_FDCC_CONTROL__SAMPLE_MASK_TRACKER_FEA_FORCE_MASK        =
                                    0x00000002L
 #define CB_COLOR3_FDCC_CONTROL__MAX_UNCOMPRESSED_BLOCK_SIZE_MASK          =
                                    0x0000000CL
@@ -19463,6 +19484,9 @@
 #define CB_COLOR3_FDCC_CONTROL__FDCC_ENABLE_MASK                          =
                                    0x00400000L
 #define CB_COLOR3_FDCC_CONTROL__DCC_COMPRESS_DISABLE_MASK                 =
                                    0x00800000L
 #define CB_COLOR3_FDCC_CONTROL__FRAGMENT_COMPRESS_DISABLE_MASK            =
                                    0x01000000L
+#define CB_COLOR3_FDCC_CONTROL__DISABLE_OVERRIDE_INCONSISTENT_KEYS_MASK   =
                                    0x02000000L
+#define CB_COLOR3_FDCC_CONTROL__ENABLE_MAX_COMP_FRAG_OVERRIDE_MASK        =
                                    0x04000000L
+#define CB_COLOR3_FDCC_CONTROL__MAX_COMP_FRAGS_MASK                       =
                                    0x38000000L
 //CB_COLOR3_DCC_BASE
 #define CB_COLOR3_DCC_BASE__BASE_256B__SHIFT                              =
                                    0x0
 #define CB_COLOR3_DCC_BASE__BASE_256B_MASK                                =
                                    0xFFFFFFFFL
@@ -19523,6 +19547,9 @@
 #define CB_COLOR4_FDCC_CONTROL__FDCC_ENABLE__SHIFT                        =
                                    0x16
 #define CB_COLOR4_FDCC_CONTROL__DCC_COMPRESS_DISABLE__SHIFT               =
                                    0x17
 #define CB_COLOR4_FDCC_CONTROL__FRAGMENT_COMPRESS_DISABLE__SHIFT          =
                                    0x18
+#define CB_COLOR4_FDCC_CONTROL__DISABLE_OVERRIDE_INCONSISTENT_KEYS__SHIFT =
                                    0x19
+#define CB_COLOR4_FDCC_CONTROL__ENABLE_MAX_COMP_FRAG_OVERRIDE__SHIFT      =
                                    0x1a
+#define CB_COLOR4_FDCC_CONTROL__MAX_COMP_FRAGS__SHIFT                     =
                                    0x1b
 #define CB_COLOR4_FDCC_CONTROL__SAMPLE_MASK_TRACKER_DISABLE_MASK          =
                                    0x00000001L
 #define CB_COLOR4_FDCC_CONTROL__SAMPLE_MASK_TRACKER_FEA_FORCE_MASK        =
                                    0x00000002L
 #define CB_COLOR4_FDCC_CONTROL__MAX_UNCOMPRESSED_BLOCK_SIZE_MASK          =
                                    0x0000000CL
@@ -19537,6 +19564,9 @@
 #define CB_COLOR4_FDCC_CONTROL__FDCC_ENABLE_MASK                          =
                                    0x00400000L
 #define CB_COLOR4_FDCC_CONTROL__DCC_COMPRESS_DISABLE_MASK                 =
                                    0x00800000L
 #define CB_COLOR4_FDCC_CONTROL__FRAGMENT_COMPRESS_DISABLE_MASK            =
                                    0x01000000L
+#define CB_COLOR4_FDCC_CONTROL__DISABLE_OVERRIDE_INCONSISTENT_KEYS_MASK   =
                                    0x02000000L
+#define CB_COLOR4_FDCC_CONTROL__ENABLE_MAX_COMP_FRAG_OVERRIDE_MASK        =
                                    0x04000000L
+#define CB_COLOR4_FDCC_CONTROL__MAX_COMP_FRAGS_MASK                       =
                                    0x38000000L
 //CB_COLOR4_DCC_BASE
 #define CB_COLOR4_DCC_BASE__BASE_256B__SHIFT                              =
                                    0x0
 #define CB_COLOR4_DCC_BASE__BASE_256B_MASK                                =
                                    0xFFFFFFFFL
@@ -19597,6 +19627,9 @@
 #define CB_COLOR5_FDCC_CONTROL__FDCC_ENABLE__SHIFT                        =
                                    0x16
 #define CB_COLOR5_FDCC_CONTROL__DCC_COMPRESS_DISABLE__SHIFT               =
                                    0x17
 #define CB_COLOR5_FDCC_CONTROL__FRAGMENT_COMPRESS_DISABLE__SHIFT          =
                                    0x18
+#define CB_COLOR5_FDCC_CONTROL__DISABLE_OVERRIDE_INCONSISTENT_KEYS__SHIFT =
                                    0x19
+#define CB_COLOR5_FDCC_CONTROL__ENABLE_MAX_COMP_FRAG_OVERRIDE__SHIFT      =
                                    0x1a
+#define CB_COLOR5_FDCC_CONTROL__MAX_COMP_FRAGS__SHIFT                     =
                                    0x1b
 #define CB_COLOR5_FDCC_CONTROL__SAMPLE_MASK_TRACKER_DISABLE_MASK          =
                                    0x00000001L
 #define CB_COLOR5_FDCC_CONTROL__SAMPLE_MASK_TRACKER_FEA_FORCE_MASK        =
                                    0x00000002L
 #define CB_COLOR5_FDCC_CONTROL__MAX_UNCOMPRESSED_BLOCK_SIZE_MASK          =
                                    0x0000000CL
@@ -19611,6 +19644,9 @@
 #define CB_COLOR5_FDCC_CONTROL__FDCC_ENABLE_MASK                          =
                                    0x00400000L
 #define CB_COLOR5_FDCC_CONTROL__DCC_COMPRESS_DISABLE_MASK                 =
                                    0x00800000L
 #define CB_COLOR5_FDCC_CONTROL__FRAGMENT_COMPRESS_DISABLE_MASK            =
                                    0x01000000L
+#define CB_COLOR5_FDCC_CONTROL__DISABLE_OVERRIDE_INCONSISTENT_KEYS_MASK   =
                                    0x02000000L
+#define CB_COLOR5_FDCC_CONTROL__ENABLE_MAX_COMP_FRAG_OVERRIDE_MASK        =
                                    0x04000000L
+#define CB_COLOR5_FDCC_CONTROL__MAX_COMP_FRAGS_MASK                       =
                                    0x38000000L
 //CB_COLOR5_DCC_BASE
 #define CB_COLOR5_DCC_BASE__BASE_256B__SHIFT                              =
                                    0x0
 #define CB_COLOR5_DCC_BASE__BASE_256B_MASK                                =
                                    0xFFFFFFFFL
@@ -19671,6 +19707,9 @@
 #define CB_COLOR6_FDCC_CONTROL__FDCC_ENABLE__SHIFT                        =
                                    0x16
 #define CB_COLOR6_FDCC_CONTROL__DCC_COMPRESS_DISABLE__SHIFT               =
                                    0x17
 #define CB_COLOR6_FDCC_CONTROL__FRAGMENT_COMPRESS_DISABLE__SHIFT          =
                                    0x18
+#define CB_COLOR6_FDCC_CONTROL__DISABLE_OVERRIDE_INCONSISTENT_KEYS__SHIFT =
                                    0x19
+#define CB_COLOR6_FDCC_CONTROL__ENABLE_MAX_COMP_FRAG_OVERRIDE__SHIFT      =
                                    0x1a
+#define CB_COLOR6_FDCC_CONTROL__MAX_COMP_FRAGS__SHIFT                     =
                                    0x1b
 #define CB_COLOR6_FDCC_CONTROL__SAMPLE_MASK_TRACKER_DISABLE_MASK          =
                                    0x00000001L
 #define CB_COLOR6_FDCC_CONTROL__SAMPLE_MASK_TRACKER_FEA_FORCE_MASK        =
                                    0x00000002L
 #define CB_COLOR6_FDCC_CONTROL__MAX_UNCOMPRESSED_BLOCK_SIZE_MASK          =
                                    0x0000000CL
@@ -19685,6 +19724,9 @@
 #define CB_COLOR6_FDCC_CONTROL__FDCC_ENABLE_MASK                          =
                                    0x00400000L
 #define CB_COLOR6_FDCC_CONTROL__DCC_COMPRESS_DISABLE_MASK                 =
                                    0x00800000L
 #define CB_COLOR6_FDCC_CONTROL__FRAGMENT_COMPRESS_DISABLE_MASK            =
                                    0x01000000L
+#define CB_COLOR6_FDCC_CONTROL__DISABLE_OVERRIDE_INCONSISTENT_KEYS_MASK   =
                                    0x02000000L
+#define CB_COLOR6_FDCC_CONTROL__ENABLE_MAX_COMP_FRAG_OVERRIDE_MASK        =
                                    0x04000000L
+#define CB_COLOR6_FDCC_CONTROL__MAX_COMP_FRAGS_MASK                       =
                                    0x38000000L
 //CB_COLOR6_DCC_BASE
 #define CB_COLOR6_DCC_BASE__BASE_256B__SHIFT                              =
                                    0x0
 #define CB_COLOR6_DCC_BASE__BASE_256B_MASK                                =
                                    0xFFFFFFFFL
@@ -19745,6 +19787,9 @@
 #define CB_COLOR7_FDCC_CONTROL__FDCC_ENABLE__SHIFT                        =
                                    0x16
 #define CB_COLOR7_FDCC_CONTROL__DCC_COMPRESS_DISABLE__SHIFT               =
                                    0x17
 #define CB_COLOR7_FDCC_CONTROL__FRAGMENT_COMPRESS_DISABLE__SHIFT          =
                                    0x18
+#define CB_COLOR7_FDCC_CONTROL__DISABLE_OVERRIDE_INCONSISTENT_KEYS__SHIFT =
                                    0x19
+#define CB_COLOR7_FDCC_CONTROL__ENABLE_MAX_COMP_FRAG_OVERRIDE__SHIFT      =
                                    0x1a
+#define CB_COLOR7_FDCC_CONTROL__MAX_COMP_FRAGS__SHIFT                     =
                                    0x1b
 #define CB_COLOR7_FDCC_CONTROL__SAMPLE_MASK_TRACKER_DISABLE_MASK          =
                                    0x00000001L
 #define CB_COLOR7_FDCC_CONTROL__SAMPLE_MASK_TRACKER_FEA_FORCE_MASK        =
                                    0x00000002L
 #define CB_COLOR7_FDCC_CONTROL__MAX_UNCOMPRESSED_BLOCK_SIZE_MASK          =
                                    0x0000000CL
@@ -19759,6 +19804,9 @@
 #define CB_COLOR7_FDCC_CONTROL__FDCC_ENABLE_MASK                          =
                                    0x00400000L
 #define CB_COLOR7_FDCC_CONTROL__DCC_COMPRESS_DISABLE_MASK                 =
                                    0x00800000L
 #define CB_COLOR7_FDCC_CONTROL__FRAGMENT_COMPRESS_DISABLE_MASK            =
                                    0x01000000L
+#define CB_COLOR7_FDCC_CONTROL__DISABLE_OVERRIDE_INCONSISTENT_KEYS_MASK   =
                                    0x02000000L
+#define CB_COLOR7_FDCC_CONTROL__ENABLE_MAX_COMP_FRAG_OVERRIDE_MASK        =
                                    0x04000000L
+#define CB_COLOR7_FDCC_CONTROL__MAX_COMP_FRAGS_MASK                       =
                                    0x38000000L
 //CB_COLOR7_DCC_BASE
 #define CB_COLOR7_DCC_BASE__BASE_256B__SHIFT                              =
                                    0x0
 #define CB_COLOR7_DCC_BASE__BASE_256B_MASK                                =
                                    0xFFFFFFFFL
--
2.41.0

