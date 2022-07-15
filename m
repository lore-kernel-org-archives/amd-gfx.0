Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78273C43334
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:39:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65BEB10FAFF;
	Sat, 16 Jul 2022 14:36:10 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22CA310E235
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 19:39:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MD1LwtfbEisGirc8KXjbSB0IIIbHGfr6K3PLTov4u0FC1ARE40l57XQYmLELVAaOfcZLWN9qsSDKbXvdtLOBXiXo52TbTOKU/1zajRvu/sEDzS9o6zByRghRRxW7nqccVbRZecyLD4O2etFvup9yW7Ofmt25Cy4E4rHmcWYIbraIzfBhXIGKufsR+NQvw2Lp9J3qcNBQlmq7DivAnaY403JdUs+RauY2LohOSkJ6JqWa4rakWLu72NMMUJEByav1OhrtbN+vLU5sqapa51GnRXTX4OU7+DOkO4Cx54yHOQnSu+Dups7b1mS/dwQ8HQk8c2raIwGyJZS+WjP9rvj7dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBSaT5MMcXK/aP4z4rSaMEihoNJT1yG0VbyLz6Y6elQ=;
 b=mAFKTdcVXUs1Dj0b0D/H7RxnmuFVW2aAF+UidhA7DubAlK6fXikf8LhyB1P/47IrMCJW0bnWhZVk5lq+Pgaf7VAYfB4iMY9eTOLCrAo64unzHa3q+wDYmFMAhSKVMNArpHjuTIup5GETBIdwKhNc6XEKjiaMtjePl6vt7yUoO1kOdaYrIOAER7NerLQqudo8xicqTZ5uf5xxw0rSWyaCkOKhHj4jwyI+ygoYfYOeXtJ7faV5EY89qIkLKAFTXnR+22fgFLP9JPlPkUD7XFcuvUFd8k/5c+HeKrsyW2FD9QxwX7vy08XVQMwYLa2wZo+Iua2KOZtjv4qGs06nAlpWqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBSaT5MMcXK/aP4z4rSaMEihoNJT1yG0VbyLz6Y6elQ=;
 b=MwQ5ufHQah+8I2AcUIHzfcqKvCFAA8pnN91PPS2V8NSedbjoXRECiYSpLQmi8HQNvHJ24WCzAGKd/cH2ngbDSNcs107CJiqgtZT6PH45Ulh9l15wVEB0EA7IWHU9CNmkqDjP3jMb75I71BimCpcEmlo01W6GKD5SbE+JlFSlMiI=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 DM5PR12MB4678.namprd12.prod.outlook.com (2603:10b6:4:a9::39) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.15; Fri, 15 Jul 2022 19:39:54 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::f5d2:bde1:c504:efee]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::f5d2:bde1:c504:efee%6]) with mapi id 15.20.5438.019; Fri, 15 Jul 2022
 19:39:54 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Dong, Ruijing" <Ruijing.Dong@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3] drm/amdgpu: add comments to HW_IP_VCN_ENC
Thread-Topic: [PATCH v3] drm/amdgpu: add comments to HW_IP_VCN_ENC
Thread-Index: AQHYmGU8tGfpTjmc6EqxYxy0+wujCa1/1G6A
Date: Fri, 15 Jul 2022 19:39:54 +0000
Message-ID: <DM8PR12MB53995EDDC7E1BCC44EA50A26E58B9@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20220715160901.137291-1-ruijing.dong@amd.com>
In-Reply-To: <20220715160901.137291-1-ruijing.dong@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=799aad80-f0b7-4d64-9c14-8a20b46ffabd;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-15T19:39:34Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b576c867-895b-451d-04f5-08da6699caef
x-ms-traffictypediagnostic: DM5PR12MB4678:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bCa6/vJvCyab67oggYPoWTYGYJc7wHhT1/JxZu+zY83cJ+LQyNGLMhJWYyCU3jpbZPMPY+LpYbKKU43zULhbxDzrHe9iilQsmutAV3GJwa7nA9X/CdTOuAA3jkQRzmVGIMQXee5JoIljbVWW9woetCUIuqVS18FOe42MY1XEXegi1kU6bQFvOR0PLwogMOcWn3o5HVOjzuHWRdLsl6W/sUVqMoX+WELKf0TQrV83Z4u3DIO0xVb6AmPq/9duYYl6QcrfGscaYLY8RJkRE2mzHCzSG95V4fd2bAQcWkbXGDS6fRcqqg1IcxXeJH15IJQrCMIleFwQYqz8io3AVFlO4t+QH0AAUnljVD0DiWV6fXVMGvLboHWSQL980DPs8gBX9rnQVoYezbUbbXmfOVN7IW2H1EX1Wr8jFoxOSJZjQhTaB9cKdEE2wsp1hFduaXz86txt3JyT+fBLZb46ius+Dz5YrsYGuaxAHXwh2B/jWzgqzA9VT/61Y5VlqR+EswHLzIEKwN9sf1GjceLv9skW6bRdoXTjkJoARS8/N9sH/LpddIK2PdkOhncHDCgrZy8wAeJoEqBucjtQMuiAt4/eYY3pZ+pN0hnaNHg519gnOhw7iQVe0azzt4nvwYaMbw3mo0OgCsp653VECgCBZARh7Vkg1AZiAiQ7rxlU8UxlbGL6HWy9CaR7h2Fywb1mZXwJuCKWRYCwzNZwJEn9e66Z+5bxb9aelVsiuAorq5nPuUBycoPBYOFmp9RClFIifhCwUuXcVQfg+zbj6DM1GfamPw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(26005)(53546011)(9686003)(2906002)(8936002)(6506007)(41300700001)(33656002)(52536014)(5660300002)(186003)(86362001)(7696005)(83380400001)(478600001)(966005)(38100700002)(316002)(66946007)(122000001)(38070700005)(76116006)(110136005)(55016003)(8676002)(66476007)(66446008)(66556008)(4326008)(64756008)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yBigXLd/HHTlfEVmO8uuo+gGrrn7YyT8EboW2doXOb6gaWNbjVW0jHf3IAKT?=
 =?us-ascii?Q?HHm0n3R5OH6qaiu/+Yb4jFt8U+onRJI4o9kSxdW8q6yhiXAUkEXQvj8TbkYy?=
 =?us-ascii?Q?1MMCR3U/n95UikyLc080BcMCgu4nbemZHkRz7CUWW219iw90telieAJKnTy6?=
 =?us-ascii?Q?/4fgRlbyL0FR+pMXxXx8Gw3dw7iA/wqPd8Hur4yzWz6b8CQThVVZhXLvz7gL?=
 =?us-ascii?Q?CpOALR6mJzqbqXXelLcJMoaLSaTEYTdu7MKveL2t/+gKP7S9fH7EUxXyblNt?=
 =?us-ascii?Q?lRqfI8W2QxQkfWpV8nOJHOEecJvwuWgm590+kLLNKjEt/WnEP/vDYidoeXcg?=
 =?us-ascii?Q?ku4VNzasW6kwXBZIwyN8hY6TewEpFtRym8GUB4h/HygFshznBb7Ni+h1SdGd?=
 =?us-ascii?Q?TaZN6aIunWD3xEujE1BM4vwTDvodV9d3eNR//mHrnDx3EyyX5kj8zXwMd91L?=
 =?us-ascii?Q?/Wan6sZGjmVQjkQ+tz0KB1TulKey3T7g5FiG51B8qL2KxsSyRheUpJVlv8jc?=
 =?us-ascii?Q?M1Z1icEPntocpqJ2z4iX0Vq8vV2bSAWgtsEzLizhgMqS7H/4oIjdfOtWO7Og?=
 =?us-ascii?Q?RrENc66wPYgmbsovoo0n+U0j4vPEcIlvHS7qXbhts88AUti7myOiA50JaMIZ?=
 =?us-ascii?Q?sqYd36hxw9n6w69n/DYQgaLXVk+/AOO+KL/xizLlzqDVsHa06QnUYm3Qs6G8?=
 =?us-ascii?Q?qC+XKj8TuiMcTHPc6QYJt4UuawbI4RKVXDgfW8GWvTDH0OF69eN1JWqSADX/?=
 =?us-ascii?Q?+8SJ9p9RL1e2JlUTI65GSDpMEvp7V8ZRklSrE5V5dlNsGke6MFwI0KBQsftq?=
 =?us-ascii?Q?8o4W8pGA2KzGJAz/koNWliE5OXvSPid/ZcXljipw2Z+b/n/6FlINces3JbJF?=
 =?us-ascii?Q?HTqyS01DZLwys9XYw6n9p94vXvyGd0Ugo1S4MvBjqGVgzHIN7AB6/pt0gwBG?=
 =?us-ascii?Q?z/fpFib5T+suWeGynlI3lpAt27gsciw45qWqxr7hqRAIYbqFmOu14IbtlAAe?=
 =?us-ascii?Q?1XDIDFhG/Msz3uUvuvawXJcgn0yxsjfXyl3JNAFj0NCkA3a5zh/MHXaNuKTL?=
 =?us-ascii?Q?rREJZPKFDNC0rCjjBzLEs7s7xgkwfeSoUh1b41ceyqt4c2skMpkhqRW+F23m?=
 =?us-ascii?Q?Ehex9lcvQ+KZ3O16fK18rfEBwGeJ2FHntJhvqwE8MM6bn16ha3bETzGJwUSb?=
 =?us-ascii?Q?UL/XrwmeY/nG0xcn5N+AQLMHF/fVTDVqbg9YmNAwrqM2xQrtl/adYGYwavr0?=
 =?us-ascii?Q?Q17D+6iR2FS+6WKwhyfqGCVZtym6uuyCdDjyTpcGku6m6espGgwh7mwmnJrX?=
 =?us-ascii?Q?iDvE683+fkHGP7GyRM3FD2v4LyNJPL8r29YmGqxbyH+ih6SkNRiGolcs6O3+?=
 =?us-ascii?Q?CQ8Zbn67KltshaATnyFQGr4oh9t0CrFEouhB1F9OOwd9sr2b5sYFvNTcHR/p?=
 =?us-ascii?Q?eSU+TM5rj1lhIs+m1gnqsZq7VXyE2dxCEeCIym5w0Tasmorlu58fglNFM2zs?=
 =?us-ascii?Q?/oQsdGMTOTEuT+ybDaxDpixCAx3kij/ZBuIriZrIql9mL4kVSWXQMtLiuXu+?=
 =?us-ascii?Q?oLNEv2T+/fI4FIvUNPk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b576c867-895b-451d-04f5-08da6699caef
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 19:39:54.6870 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SVG8H3eAeMq3qO9bpt2car1SG2v275fqRr6pmgOBSAHu6bJoygYwtM0OrWV9A786
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4678
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

Reviewed-by: Leo Liu <leo.liu@amd.com>

-----Original Message-----
From: Dong, Ruijing <Ruijing.Dong@amd.com>
Sent: July 15, 2022 12:09 PM
To: Koenig, Christian <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop=
.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Leo <Leo.Liu@amd.c=
om>; Dong, Ruijing <Ruijing.Dong@amd.com>
Subject: [PATCH v3] drm/amdgpu: add comments to HW_IP_VCN_ENC

From VCN4, HW_IP_VCN_ENC will be used as unified queue, and support both en=
coding and decoding jobs, HW_IP_VCN_DEC is retired from VCN4.

link: https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/245/commits

Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h =
index 18d3246d636e..29e4a1ece2ce 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -559,7 +559,14 @@ struct drm_amdgpu_gem_va {
 #define AMDGPU_HW_IP_VCE          4
 #define AMDGPU_HW_IP_UVD_ENC      5
 #define AMDGPU_HW_IP_VCN_DEC      6
+
+/**
+ * From VCN4, AMDGPU_HW_IP_VCN_ENC will be used as unified queue
+ * and support both encoding and decoding jobs, AMDGPU_HW_IP_VCN_DEC
+ * is retired from VCN4.
+ */
 #define AMDGPU_HW_IP_VCN_ENC      7
+
 #define AMDGPU_HW_IP_VCN_JPEG     8
 #define AMDGPU_HW_IP_NUM          9

--
2.25.1

