Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B33C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 06:07:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AB086191D
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 06:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB086191D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C3CE6E9C4;
	Tue, 11 May 2021 06:07:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC4996E9C4
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 06:07:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMeKSegSTuUc7cCCuUszAg7PCUFI4ulMKCfwKYS8W5uVBWfIRDQxN+xQa7w7X4/Qy6qWQCP/fnnggaozgT97FhCSsIfCHw/MAj79SE1ubdvHojq1vONyEc9zO2U67TOwbPSIvOUf2iW3bTWwmfGwQ8FrbzKSdlj97rt0TvSTu7LLjumI7noVDg/KKStj3V+PpRzgykVm3RVlBsjjdEIqLSE4JI4s5f/hQJODQ3wA8lmAeJlZdSS2luIPwEeP8OV2ufglXoXPpqgts/DMTB955ILIh4+zkp4X0xw7XtaQMJYlaO0bhuxKBKA0oeUzweQleLVxULmnfpBHBMeCOH9yyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FC8m+7rhZnjPtgrhlt4MPbuITVohcEwY2v+ojZXZX/4=;
 b=MOwZbJod8kRQgkes2+kSdC5PN4qIYnhoWGY9LNt1Q9byvWABUTF6QJyB4Hro2iVHQwlMlj/pGAnal4YrZEXxTchvFoFg2li+7T76QEz4Gg8L1IAAWD/X+mxnVbQ/UUabCJCNKEzJv0aNgLOa0SaK35MtiRVUGENky/IpwMP+PfwS0xsXQyWlC2T8k7vVTMJuXxim8To28QZENedeOQtmHBa9wjavFjI8y2cey3WjkVIh6rLYgFUXbNvAUtPpzQzZp4U/MtPZTjv6alkt4E1iJ4CagH5GKroY9nYcoD+rzQqg5zT1dhK9D853326Q1I18ITD0Ln79nascDY1sdvfN6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FC8m+7rhZnjPtgrhlt4MPbuITVohcEwY2v+ojZXZX/4=;
 b=CVfCBk5CK4kxqtqLs7WOEXBgnc4Ckdv3m8q1jKCC4dAD4379XI2P6XbukcFlXUJcTB8xCshatsKfJmjEgEbRemexTAk5+F7EoDfpG1B+44hDPTv8WnxvaeYnHOMUt6oGxsBO2+IQf4Hm45fZkoujNTy2CWi8N9+GEQJaMB/5rQ4=
Received: from BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 by BN9PR12MB5131.namprd12.prod.outlook.com (2603:10b6:408:118::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.31; Tue, 11 May
 2021 06:07:12 +0000
Received: from BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85]) by BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85%6]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 06:07:12 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add synchronization among waves in the same
 threadgroup
Thread-Topic: [PATCH] drm/amdgpu: add synchronization among waves in the same
 threadgroup
Thread-Index: AQHXRiuE1KA3V1Eq+0CT5QxyiNS42ardy09Q
Date: Tue, 11 May 2021 06:07:12 +0000
Message-ID: <BN9PR12MB5368D93EF2A4B6B3B2D3C8D7FC539@BN9PR12MB5368.namprd12.prod.outlook.com>
References: <20210511060420.30820-1-Dennis.Li@amd.com>
In-Reply-To: <20210511060420.30820-1-Dennis.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-11T06:07:09Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=f4a0273b-f36f-44ef-94e1-e94a3a569fcf;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8e63c05-4f76-4c25-78f4-08d9144304fa
x-ms-traffictypediagnostic: BN9PR12MB5131:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB51313E3DF289DD2BD7963B2DFC539@BN9PR12MB5131.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jjAYJtE4kb3uCUNGRk4ZNubyq37r2I24lMFGtPOC5gKDqoMNUv2f7Xd58gloyvjssny18D92fu19PWAofXxiAFs+nQuwc/9Jj84H4yb8M16tNOaiNzr14+gazqE/A6SYl9ALXmvi1Qg2hvF5/WIzW8VU40kQomGoiXTT/Mka2QBgQTM8qNtFsb5gHIrfdhkXP++Z8L4mvpvn1ylkXQZqTTK+B+/VXqvp48mjN490wl5P9D6ShI977/UtTzPCDMP9ssxH4PEAhfXUGPAlj0aI08kAAnza3gvpJR6j1+9YKDtQ9U4nLdpDk1VeDv3P655ixOAk6VKUkFu1JixYsf8rj+8JO14KeH0LVrvk3V8SYDMluKsuATfS1vuPD6kTx0XgHalVNDZGMtOTCftPrRhrR1TeK60v7MvLrcWY/apbAWmQFnz1bZjO5dKWg4w6AXSdFWdkFo9VyKCgvb48TQkGRLjHzCZPQOvIkwBKC9248KloIfw9NE/v8iUQgEa+3V2cgQc84OBqPxTRpvA3+KYeUR2fM061CshXXG6uRbetVSA5hbs4ichGrczgJ1suCEOvP2zxBIKt3Q4qWNWbHiqX63pz+UWbjVPMptugZnso9z8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(76116006)(110136005)(55016002)(8936002)(7696005)(186003)(9686003)(66476007)(5660300002)(6636002)(86362001)(30864003)(66556008)(83380400001)(66446008)(66946007)(71200400001)(64756008)(26005)(316002)(2906002)(52536014)(38100700002)(122000001)(33656002)(6506007)(8676002)(478600001)(53546011)(4326008)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?s9O8vCu9ZbV4/fkNuzVN5iNhDaqHF0JcSlZI7WQ8Hfur3q5LsXyxl1MZBbjj?=
 =?us-ascii?Q?VW37OVkuq98dW8oMdfAInBXJyRH8GWWh5zPWfsWj3Zhw1nptAZUTj/kpZ0L8?=
 =?us-ascii?Q?PSvLq6k6R43ruZDvlOKMF5frnxqIu4WDgznLGNsPoNoy3CUB73pHWp17//yj?=
 =?us-ascii?Q?FilhVS9LQgZmsPC+Sm3SYdm/iw8WRmoOogEypqLX4rGrBQ3tqgGUkvr0bnz+?=
 =?us-ascii?Q?qzipSgtmfp3W+Gw2NlLBYJSFOw7mX23Z6SGhM+YehVXLthnUkS/Sw6v6nvM1?=
 =?us-ascii?Q?dEmeoLtQy8uHeDiST1j0PfyWNH8TVOlgRfAsmSuwTW9kMF9NFSSahiuge3fI?=
 =?us-ascii?Q?GLBIwLTxn0B99zKU8Hae6dQsoWXe0t+KBAVKa8hYOoeZigQqd25MljpGwEcc?=
 =?us-ascii?Q?rFKQUZFdC8ox9o/+eO7EO1qdvcg8VDEpeolLEJZJ9iXTOXdeWT4dz3p/WTgd?=
 =?us-ascii?Q?ICXzswY21dpFWCWqfEt6wtglamd0kcjQJRMAkJZCb9iPwtr2QOspf+Cqm75r?=
 =?us-ascii?Q?fW93NZhTmesg/pNAxPl35DjmFjQXXYeZTYJ5hkPrxKvueIw3d5Vwb3k8vVBL?=
 =?us-ascii?Q?bynSeBFvGvJHNHiMjHmfaehoOks59oY1v5ZzzIA56GJhyE8JXatNXytC+aXR?=
 =?us-ascii?Q?IMO3/cff/QUcopeghl16T8SUxkMPu6zQfQi8rxwFZX0ciSNWHF10gGrVO40g?=
 =?us-ascii?Q?cQbsNQ7YZL7Fq4WqoLMIWjkHyydR6+euza0RR6kwYvZgX0pu0TI2n9Jp85NI?=
 =?us-ascii?Q?CKSLWH03jed6OssKD4hrorFkHBJv8nw0cRXha6ATmw9/McXiGCcxB0jQ5TyO?=
 =?us-ascii?Q?Oo1uYzTip7eI36qQJwmNG3YwVh3PRDCFYulSOoOXb9VBr5UzqvDtUBy+l0Oe?=
 =?us-ascii?Q?ie/UyzfiAUYOmB4dRK3mb4mZxTVk7Dp+HJ9iJaAoeCPFzh51ni1E5PqYTpqD?=
 =?us-ascii?Q?+HSndOH65ABi4uJzw/c2T2ev3ripLQnmJuTBzneuz/shdJJxKFzfcf641OQI?=
 =?us-ascii?Q?M8RWR4GqxB84oObd7ANBKKWYLPe3hqfw102J3kfVOq/SMhpt/aFBJVBUYfG/?=
 =?us-ascii?Q?VHLGhpihBxHkIDzKWycjjiqBH6LVeOthmhYva1Kh+zH2agbBYDifG22I1GUu?=
 =?us-ascii?Q?oCyIxL0LHU5AbULzd/ZbxhG7o3rfIaQYd6IYjwxo/TGHWCRR1R8PLfmyXSO+?=
 =?us-ascii?Q?50LPYEsMYkOKkugUFMzGHrA+y98vWH0IBHW0nhdksILpkE9t4Qs3V/71h6/B?=
 =?us-ascii?Q?rptGI4XfRXqm5SZ4+0F8F3EgI60wUGYOmne3r7HqjT4C5h+MGzQx1j2YxLaO?=
 =?us-ascii?Q?KXxM7qYU2lxhFQq67IDIx1Lz?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e63c05-4f76-4c25-78f4-08d9144304fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 06:07:12.5238 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fw9XZg5pd+2e6Inpl05ZQ/TUVdJmZDmNT+sE8Vi2T56cmDXYz1w+/ooBPvReNjTJ+/Z+bpCfMgBLZVypTd5sFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5131
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
Cc: "Li, Dennis" <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Dennis Li <Dennis.Li@amd.com> 
Sent: Tuesday, May 11, 2021 14:04
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH] drm/amdgpu: add synchronization among waves in the same threadgroup

It is possible that the previous waves have exited before others are created, so the other waves maybe reuse pyhsical resouces left by previous ones. Therefore add barrier instruction to synchronize waves within the same threadgroup.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index fdd65589f06b..dbad9ef002d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -93,98 +93,99 @@ static const struct soc15_reg_golden golden_settings_gc_9_4_2_alde[] = {  static const u32 vgpr_init_compute_shader_aldebaran[] = {
 	0xb8840904, 0xb8851a04, 0xb8861344, 0xb8831804, 0x9208ff06, 0x00000280,
 	0x9209a805, 0x920a8a04, 0x81080908, 0x81080a08, 0x81080308, 0x8e078208,
-	0x81078407, 0xc0410080, 0x00000007, 0xbf8c0000, 0xd3d94000, 0x18000080,
-	0xd3d94001, 0x18000080, 0xd3d94002, 0x18000080, 0xd3d94003, 0x18000080,
-	0xd3d94004, 0x18000080, 0xd3d94005, 0x18000080, 0xd3d94006, 0x18000080,
-	0xd3d94007, 0x18000080, 0xd3d94008, 0x18000080, 0xd3d94009, 0x18000080,
-	0xd3d9400a, 0x18000080, 0xd3d9400b, 0x18000080, 0xd3d9400c, 0x18000080,
-	0xd3d9400d, 0x18000080, 0xd3d9400e, 0x18000080, 0xd3d9400f, 0x18000080,
-	0xd3d94010, 0x18000080, 0xd3d94011, 0x18000080, 0xd3d94012, 0x18000080,
-	0xd3d94013, 0x18000080, 0xd3d94014, 0x18000080, 0xd3d94015, 0x18000080,
-	0xd3d94016, 0x18000080, 0xd3d94017, 0x18000080, 0xd3d94018, 0x18000080,
-	0xd3d94019, 0x18000080, 0xd3d9401a, 0x18000080, 0xd3d9401b, 0x18000080,
-	0xd3d9401c, 0x18000080, 0xd3d9401d, 0x18000080, 0xd3d9401e, 0x18000080,
-	0xd3d9401f, 0x18000080, 0xd3d94020, 0x18000080, 0xd3d94021, 0x18000080,
-	0xd3d94022, 0x18000080, 0xd3d94023, 0x18000080, 0xd3d94024, 0x18000080,
-	0xd3d94025, 0x18000080, 0xd3d94026, 0x18000080, 0xd3d94027, 0x18000080,
-	0xd3d94028, 0x18000080, 0xd3d94029, 0x18000080, 0xd3d9402a, 0x18000080,
-	0xd3d9402b, 0x18000080, 0xd3d9402c, 0x18000080, 0xd3d9402d, 0x18000080,
-	0xd3d9402e, 0x18000080, 0xd3d9402f, 0x18000080, 0xd3d94030, 0x18000080,
-	0xd3d94031, 0x18000080, 0xd3d94032, 0x18000080, 0xd3d94033, 0x18000080,
-	0xd3d94034, 0x18000080, 0xd3d94035, 0x18000080, 0xd3d94036, 0x18000080,
-	0xd3d94037, 0x18000080, 0xd3d94038, 0x18000080, 0xd3d94039, 0x18000080,
-	0xd3d9403a, 0x18000080, 0xd3d9403b, 0x18000080, 0xd3d9403c, 0x18000080,
-	0xd3d9403d, 0x18000080, 0xd3d9403e, 0x18000080, 0xd3d9403f, 0x18000080,
-	0xd3d94040, 0x18000080, 0xd3d94041, 0x18000080, 0xd3d94042, 0x18000080,
-	0xd3d94043, 0x18000080, 0xd3d94044, 0x18000080, 0xd3d94045, 0x18000080,
-	0xd3d94046, 0x18000080, 0xd3d94047, 0x18000080, 0xd3d94048, 0x18000080,
-	0xd3d94049, 0x18000080, 0xd3d9404a, 0x18000080, 0xd3d9404b, 0x18000080,
-	0xd3d9404c, 0x18000080, 0xd3d9404d, 0x18000080, 0xd3d9404e, 0x18000080,
-	0xd3d9404f, 0x18000080, 0xd3d94050, 0x18000080, 0xd3d94051, 0x18000080,
-	0xd3d94052, 0x18000080, 0xd3d94053, 0x18000080, 0xd3d94054, 0x18000080,
-	0xd3d94055, 0x18000080, 0xd3d94056, 0x18000080, 0xd3d94057, 0x18000080,
-	0xd3d94058, 0x18000080, 0xd3d94059, 0x18000080, 0xd3d9405a, 0x18000080,
-	0xd3d9405b, 0x18000080, 0xd3d9405c, 0x18000080, 0xd3d9405d, 0x18000080,
-	0xd3d9405e, 0x18000080, 0xd3d9405f, 0x18000080, 0xd3d94060, 0x18000080,
-	0xd3d94061, 0x18000080, 0xd3d94062, 0x18000080, 0xd3d94063, 0x18000080,
-	0xd3d94064, 0x18000080, 0xd3d94065, 0x18000080, 0xd3d94066, 0x18000080,
-	0xd3d94067, 0x18000080, 0xd3d94068, 0x18000080, 0xd3d94069, 0x18000080,
-	0xd3d9406a, 0x18000080, 0xd3d9406b, 0x18000080, 0xd3d9406c, 0x18000080,
-	0xd3d9406d, 0x18000080, 0xd3d9406e, 0x18000080, 0xd3d9406f, 0x18000080,
-	0xd3d94070, 0x18000080, 0xd3d94071, 0x18000080, 0xd3d94072, 0x18000080,
-	0xd3d94073, 0x18000080, 0xd3d94074, 0x18000080, 0xd3d94075, 0x18000080,
-	0xd3d94076, 0x18000080, 0xd3d94077, 0x18000080, 0xd3d94078, 0x18000080,
-	0xd3d94079, 0x18000080, 0xd3d9407a, 0x18000080, 0xd3d9407b, 0x18000080,
-	0xd3d9407c, 0x18000080, 0xd3d9407d, 0x18000080, 0xd3d9407e, 0x18000080,
-	0xd3d9407f, 0x18000080, 0xd3d94080, 0x18000080, 0xd3d94081, 0x18000080,
-	0xd3d94082, 0x18000080, 0xd3d94083, 0x18000080, 0xd3d94084, 0x18000080,
-	0xd3d94085, 0x18000080, 0xd3d94086, 0x18000080, 0xd3d94087, 0x18000080,
-	0xd3d94088, 0x18000080, 0xd3d94089, 0x18000080, 0xd3d9408a, 0x18000080,
-	0xd3d9408b, 0x18000080, 0xd3d9408c, 0x18000080, 0xd3d9408d, 0x18000080,
-	0xd3d9408e, 0x18000080, 0xd3d9408f, 0x18000080, 0xd3d94090, 0x18000080,
-	0xd3d94091, 0x18000080, 0xd3d94092, 0x18000080, 0xd3d94093, 0x18000080,
-	0xd3d94094, 0x18000080, 0xd3d94095, 0x18000080, 0xd3d94096, 0x18000080,
-	0xd3d94097, 0x18000080, 0xd3d94098, 0x18000080, 0xd3d94099, 0x18000080,
-	0xd3d9409a, 0x18000080, 0xd3d9409b, 0x18000080, 0xd3d9409c, 0x18000080,
-	0xd3d9409d, 0x18000080, 0xd3d9409e, 0x18000080, 0xd3d9409f, 0x18000080,
-	0xd3d940a0, 0x18000080, 0xd3d940a1, 0x18000080, 0xd3d940a2, 0x18000080,
-	0xd3d940a3, 0x18000080, 0xd3d940a4, 0x18000080, 0xd3d940a5, 0x18000080,
-	0xd3d940a6, 0x18000080, 0xd3d940a7, 0x18000080, 0xd3d940a8, 0x18000080,
-	0xd3d940a9, 0x18000080, 0xd3d940aa, 0x18000080, 0xd3d940ab, 0x18000080,
-	0xd3d940ac, 0x18000080, 0xd3d940ad, 0x18000080, 0xd3d940ae, 0x18000080,
-	0xd3d940af, 0x18000080, 0xd3d940b0, 0x18000080, 0xd3d940b1, 0x18000080,
-	0xd3d940b2, 0x18000080, 0xd3d940b3, 0x18000080, 0xd3d940b4, 0x18000080,
-	0xd3d940b5, 0x18000080, 0xd3d940b6, 0x18000080, 0xd3d940b7, 0x18000080,
-	0xd3d940b8, 0x18000080, 0xd3d940b9, 0x18000080, 0xd3d940ba, 0x18000080,
-	0xd3d940bb, 0x18000080, 0xd3d940bc, 0x18000080, 0xd3d940bd, 0x18000080,
-	0xd3d940be, 0x18000080, 0xd3d940bf, 0x18000080, 0xd3d940c0, 0x18000080,
-	0xd3d940c1, 0x18000080, 0xd3d940c2, 0x18000080, 0xd3d940c3, 0x18000080,
-	0xd3d940c4, 0x18000080, 0xd3d940c5, 0x18000080, 0xd3d940c6, 0x18000080,
-	0xd3d940c7, 0x18000080, 0xd3d940c8, 0x18000080, 0xd3d940c9, 0x18000080,
-	0xd3d940ca, 0x18000080, 0xd3d940cb, 0x18000080, 0xd3d940cc, 0x18000080,
-	0xd3d940cd, 0x18000080, 0xd3d940ce, 0x18000080, 0xd3d940cf, 0x18000080,
-	0xd3d940d0, 0x18000080, 0xd3d940d1, 0x18000080, 0xd3d940d2, 0x18000080,
-	0xd3d940d3, 0x18000080, 0xd3d940d4, 0x18000080, 0xd3d940d5, 0x18000080,
-	0xd3d940d6, 0x18000080, 0xd3d940d7, 0x18000080, 0xd3d940d8, 0x18000080,
-	0xd3d940d9, 0x18000080, 0xd3d940da, 0x18000080, 0xd3d940db, 0x18000080,
-	0xd3d940dc, 0x18000080, 0xd3d940dd, 0x18000080, 0xd3d940de, 0x18000080,
-	0xd3d940df, 0x18000080, 0xd3d940e0, 0x18000080, 0xd3d940e1, 0x18000080,
-	0xd3d940e2, 0x18000080, 0xd3d940e3, 0x18000080, 0xd3d940e4, 0x18000080,
-	0xd3d940e5, 0x18000080, 0xd3d940e6, 0x18000080, 0xd3d940e7, 0x18000080,
-	0xd3d940e8, 0x18000080, 0xd3d940e9, 0x18000080, 0xd3d940ea, 0x18000080,
-	0xd3d940eb, 0x18000080, 0xd3d940ec, 0x18000080, 0xd3d940ed, 0x18000080,
-	0xd3d940ee, 0x18000080, 0xd3d940ef, 0x18000080, 0xd3d940f0, 0x18000080,
-	0xd3d940f1, 0x18000080, 0xd3d940f2, 0x18000080, 0xd3d940f3, 0x18000080,
-	0xd3d940f4, 0x18000080, 0xd3d940f5, 0x18000080, 0xd3d940f6, 0x18000080,
-	0xd3d940f7, 0x18000080, 0xd3d940f8, 0x18000080, 0xd3d940f9, 0x18000080,
-	0xd3d940fa, 0x18000080, 0xd3d940fb, 0x18000080, 0xd3d940fc, 0x18000080,
-	0xd3d940fd, 0x18000080, 0xd3d940fe, 0x18000080, 0xd3d940ff, 0x18000080,
-	0xb07c0000, 0xbe8a00ff, 0x000000f8, 0xbf11080a, 0x7e000280, 0x7e020280,
-	0x7e040280, 0x7e060280, 0x7e080280, 0x7e0a0280, 0x7e0c0280, 0x7e0e0280,
-	0x808a880a, 0xbe80320a, 0xbf84fff5, 0xbf9c0000, 0xd28c0001, 0x0001007f,
-	0xd28d0001, 0x0002027e, 0x10020288, 0xbe8b0004, 0xb78b4000, 0xd1196a01,
-	0x00001701, 0xbe8a0087, 0xbefc00c1, 0xd89c4000, 0x00020201, 0xd89cc080,
-	0x00040401, 0x320202ff, 0x00000800, 0x808a810a, 0xbf84fff8, 0xbf810000,
+	0x81078407, 0xc0410080, 0x00000007, 0xbf8c0000, 0xbf8a0000, 0xd3d94000,
+	0x18000080, 0xd3d94001, 0x18000080, 0xd3d94002, 0x18000080, 0xd3d94003,
+	0x18000080, 0xd3d94004, 0x18000080, 0xd3d94005, 0x18000080, 0xd3d94006,
+	0x18000080, 0xd3d94007, 0x18000080, 0xd3d94008, 0x18000080, 0xd3d94009,
+	0x18000080, 0xd3d9400a, 0x18000080, 0xd3d9400b, 0x18000080, 0xd3d9400c,
+	0x18000080, 0xd3d9400d, 0x18000080, 0xd3d9400e, 0x18000080, 0xd3d9400f,
+	0x18000080, 0xd3d94010, 0x18000080, 0xd3d94011, 0x18000080, 0xd3d94012,
+	0x18000080, 0xd3d94013, 0x18000080, 0xd3d94014, 0x18000080, 0xd3d94015,
+	0x18000080, 0xd3d94016, 0x18000080, 0xd3d94017, 0x18000080, 0xd3d94018,
+	0x18000080, 0xd3d94019, 0x18000080, 0xd3d9401a, 0x18000080, 0xd3d9401b,
+	0x18000080, 0xd3d9401c, 0x18000080, 0xd3d9401d, 0x18000080, 0xd3d9401e,
+	0x18000080, 0xd3d9401f, 0x18000080, 0xd3d94020, 0x18000080, 0xd3d94021,
+	0x18000080, 0xd3d94022, 0x18000080, 0xd3d94023, 0x18000080, 0xd3d94024,
+	0x18000080, 0xd3d94025, 0x18000080, 0xd3d94026, 0x18000080, 0xd3d94027,
+	0x18000080, 0xd3d94028, 0x18000080, 0xd3d94029, 0x18000080, 0xd3d9402a,
+	0x18000080, 0xd3d9402b, 0x18000080, 0xd3d9402c, 0x18000080, 0xd3d9402d,
+	0x18000080, 0xd3d9402e, 0x18000080, 0xd3d9402f, 0x18000080, 0xd3d94030,
+	0x18000080, 0xd3d94031, 0x18000080, 0xd3d94032, 0x18000080, 0xd3d94033,
+	0x18000080, 0xd3d94034, 0x18000080, 0xd3d94035, 0x18000080, 0xd3d94036,
+	0x18000080, 0xd3d94037, 0x18000080, 0xd3d94038, 0x18000080, 0xd3d94039,
+	0x18000080, 0xd3d9403a, 0x18000080, 0xd3d9403b, 0x18000080, 0xd3d9403c,
+	0x18000080, 0xd3d9403d, 0x18000080, 0xd3d9403e, 0x18000080, 0xd3d9403f,
+	0x18000080, 0xd3d94040, 0x18000080, 0xd3d94041, 0x18000080, 0xd3d94042,
+	0x18000080, 0xd3d94043, 0x18000080, 0xd3d94044, 0x18000080, 0xd3d94045,
+	0x18000080, 0xd3d94046, 0x18000080, 0xd3d94047, 0x18000080, 0xd3d94048,
+	0x18000080, 0xd3d94049, 0x18000080, 0xd3d9404a, 0x18000080, 0xd3d9404b,
+	0x18000080, 0xd3d9404c, 0x18000080, 0xd3d9404d, 0x18000080, 0xd3d9404e,
+	0x18000080, 0xd3d9404f, 0x18000080, 0xd3d94050, 0x18000080, 0xd3d94051,
+	0x18000080, 0xd3d94052, 0x18000080, 0xd3d94053, 0x18000080, 0xd3d94054,
+	0x18000080, 0xd3d94055, 0x18000080, 0xd3d94056, 0x18000080, 0xd3d94057,
+	0x18000080, 0xd3d94058, 0x18000080, 0xd3d94059, 0x18000080, 0xd3d9405a,
+	0x18000080, 0xd3d9405b, 0x18000080, 0xd3d9405c, 0x18000080, 0xd3d9405d,
+	0x18000080, 0xd3d9405e, 0x18000080, 0xd3d9405f, 0x18000080, 0xd3d94060,
+	0x18000080, 0xd3d94061, 0x18000080, 0xd3d94062, 0x18000080, 0xd3d94063,
+	0x18000080, 0xd3d94064, 0x18000080, 0xd3d94065, 0x18000080, 0xd3d94066,
+	0x18000080, 0xd3d94067, 0x18000080, 0xd3d94068, 0x18000080, 0xd3d94069,
+	0x18000080, 0xd3d9406a, 0x18000080, 0xd3d9406b, 0x18000080, 0xd3d9406c,
+	0x18000080, 0xd3d9406d, 0x18000080, 0xd3d9406e, 0x18000080, 0xd3d9406f,
+	0x18000080, 0xd3d94070, 0x18000080, 0xd3d94071, 0x18000080, 0xd3d94072,
+	0x18000080, 0xd3d94073, 0x18000080, 0xd3d94074, 0x18000080, 0xd3d94075,
+	0x18000080, 0xd3d94076, 0x18000080, 0xd3d94077, 0x18000080, 0xd3d94078,
+	0x18000080, 0xd3d94079, 0x18000080, 0xd3d9407a, 0x18000080, 0xd3d9407b,
+	0x18000080, 0xd3d9407c, 0x18000080, 0xd3d9407d, 0x18000080, 0xd3d9407e,
+	0x18000080, 0xd3d9407f, 0x18000080, 0xd3d94080, 0x18000080, 0xd3d94081,
+	0x18000080, 0xd3d94082, 0x18000080, 0xd3d94083, 0x18000080, 0xd3d94084,
+	0x18000080, 0xd3d94085, 0x18000080, 0xd3d94086, 0x18000080, 0xd3d94087,
+	0x18000080, 0xd3d94088, 0x18000080, 0xd3d94089, 0x18000080, 0xd3d9408a,
+	0x18000080, 0xd3d9408b, 0x18000080, 0xd3d9408c, 0x18000080, 0xd3d9408d,
+	0x18000080, 0xd3d9408e, 0x18000080, 0xd3d9408f, 0x18000080, 0xd3d94090,
+	0x18000080, 0xd3d94091, 0x18000080, 0xd3d94092, 0x18000080, 0xd3d94093,
+	0x18000080, 0xd3d94094, 0x18000080, 0xd3d94095, 0x18000080, 0xd3d94096,
+	0x18000080, 0xd3d94097, 0x18000080, 0xd3d94098, 0x18000080, 0xd3d94099,
+	0x18000080, 0xd3d9409a, 0x18000080, 0xd3d9409b, 0x18000080, 0xd3d9409c,
+	0x18000080, 0xd3d9409d, 0x18000080, 0xd3d9409e, 0x18000080, 0xd3d9409f,
+	0x18000080, 0xd3d940a0, 0x18000080, 0xd3d940a1, 0x18000080, 0xd3d940a2,
+	0x18000080, 0xd3d940a3, 0x18000080, 0xd3d940a4, 0x18000080, 0xd3d940a5,
+	0x18000080, 0xd3d940a6, 0x18000080, 0xd3d940a7, 0x18000080, 0xd3d940a8,
+	0x18000080, 0xd3d940a9, 0x18000080, 0xd3d940aa, 0x18000080, 0xd3d940ab,
+	0x18000080, 0xd3d940ac, 0x18000080, 0xd3d940ad, 0x18000080, 0xd3d940ae,
+	0x18000080, 0xd3d940af, 0x18000080, 0xd3d940b0, 0x18000080, 0xd3d940b1,
+	0x18000080, 0xd3d940b2, 0x18000080, 0xd3d940b3, 0x18000080, 0xd3d940b4,
+	0x18000080, 0xd3d940b5, 0x18000080, 0xd3d940b6, 0x18000080, 0xd3d940b7,
+	0x18000080, 0xd3d940b8, 0x18000080, 0xd3d940b9, 0x18000080, 0xd3d940ba,
+	0x18000080, 0xd3d940bb, 0x18000080, 0xd3d940bc, 0x18000080, 0xd3d940bd,
+	0x18000080, 0xd3d940be, 0x18000080, 0xd3d940bf, 0x18000080, 0xd3d940c0,
+	0x18000080, 0xd3d940c1, 0x18000080, 0xd3d940c2, 0x18000080, 0xd3d940c3,
+	0x18000080, 0xd3d940c4, 0x18000080, 0xd3d940c5, 0x18000080, 0xd3d940c6,
+	0x18000080, 0xd3d940c7, 0x18000080, 0xd3d940c8, 0x18000080, 0xd3d940c9,
+	0x18000080, 0xd3d940ca, 0x18000080, 0xd3d940cb, 0x18000080, 0xd3d940cc,
+	0x18000080, 0xd3d940cd, 0x18000080, 0xd3d940ce, 0x18000080, 0xd3d940cf,
+	0x18000080, 0xd3d940d0, 0x18000080, 0xd3d940d1, 0x18000080, 0xd3d940d2,
+	0x18000080, 0xd3d940d3, 0x18000080, 0xd3d940d4, 0x18000080, 0xd3d940d5,
+	0x18000080, 0xd3d940d6, 0x18000080, 0xd3d940d7, 0x18000080, 0xd3d940d8,
+	0x18000080, 0xd3d940d9, 0x18000080, 0xd3d940da, 0x18000080, 0xd3d940db,
+	0x18000080, 0xd3d940dc, 0x18000080, 0xd3d940dd, 0x18000080, 0xd3d940de,
+	0x18000080, 0xd3d940df, 0x18000080, 0xd3d940e0, 0x18000080, 0xd3d940e1,
+	0x18000080, 0xd3d940e2, 0x18000080, 0xd3d940e3, 0x18000080, 0xd3d940e4,
+	0x18000080, 0xd3d940e5, 0x18000080, 0xd3d940e6, 0x18000080, 0xd3d940e7,
+	0x18000080, 0xd3d940e8, 0x18000080, 0xd3d940e9, 0x18000080, 0xd3d940ea,
+	0x18000080, 0xd3d940eb, 0x18000080, 0xd3d940ec, 0x18000080, 0xd3d940ed,
+	0x18000080, 0xd3d940ee, 0x18000080, 0xd3d940ef, 0x18000080, 0xd3d940f0,
+	0x18000080, 0xd3d940f1, 0x18000080, 0xd3d940f2, 0x18000080, 0xd3d940f3,
+	0x18000080, 0xd3d940f4, 0x18000080, 0xd3d940f5, 0x18000080, 0xd3d940f6,
+	0x18000080, 0xd3d940f7, 0x18000080, 0xd3d940f8, 0x18000080, 0xd3d940f9,
+	0x18000080, 0xd3d940fa, 0x18000080, 0xd3d940fb, 0x18000080, 0xd3d940fc,
+	0x18000080, 0xd3d940fd, 0x18000080, 0xd3d940fe, 0x18000080, 0xd3d940ff,
+	0x18000080, 0xb07c0000, 0xbe8a00ff, 0x000000f8, 0xbf11080a, 0x7e000280,
+	0x7e020280, 0x7e040280, 0x7e060280, 0x7e080280, 0x7e0a0280, 0x7e0c0280,
+	0x7e0e0280, 0x808a880a, 0xbe80320a, 0xbf84fff5, 0xbf9c0000, 0xd28c0001,
+	0x0001007f, 0xd28d0001, 0x0002027e, 0x10020288, 0xbe8b0004, 0xb78b4000,
+	0xd1196a01, 0x00001701, 0xbe8a0087, 0xbefc00c1, 0xd89c4000, 0x00020201,
+	0xd89cc080, 0x00040401, 0x320202ff, 0x00000800, 0x808a810a, 0xbf84fff8,
+	0xbf810000,
 };
 
 const struct soc15_reg_entry vgpr_init_regs_aldebaran[] = { @@ -220,24 +221,25 @@ static const u32 sgpr112_init_compute_shader_aldebaran[] = {
 	0x9209a805, 0x920a8a04, 0x81080908, 0x81080a08, 0x81080308, 0x8e078208,
 	0x81078407, 0xc0410080, 0x00000007, 0xbf8c0000, 0xbf8e003f, 0xc0030200,
 	0x00000000, 0xbf8c0000, 0xbf06ff08, 0xdeadbeaf, 0xbf84fff9, 0x81028102,
-	0xc0410080, 0x00000007, 0xbf8c0000, 0xbefc0080, 0xbeea0080, 0xbeeb0080,
-	0xbf00f280, 0xbee60080, 0xbee70080, 0xbee80080, 0xbee90080, 0xbefe0080,
-	0xbeff0080, 0xbe880080, 0xbe890080, 0xbe8a0080, 0xbe8b0080, 0xbe8c0080,
-	0xbe8d0080, 0xbe8e0080, 0xbe8f0080, 0xbe900080, 0xbe910080, 0xbe920080,
-	0xbe930080, 0xbe940080, 0xbe950080, 0xbe960080, 0xbe970080, 0xbe980080,
-	0xbe990080, 0xbe9a0080, 0xbe9b0080, 0xbe9c0080, 0xbe9d0080, 0xbe9e0080,
-	0xbe9f0080, 0xbea00080, 0xbea10080, 0xbea20080, 0xbea30080, 0xbea40080,
-	0xbea50080, 0xbea60080, 0xbea70080, 0xbea80080, 0xbea90080, 0xbeaa0080,
-	0xbeab0080, 0xbeac0080, 0xbead0080, 0xbeae0080, 0xbeaf0080, 0xbeb00080,
-	0xbeb10080, 0xbeb20080, 0xbeb30080, 0xbeb40080, 0xbeb50080, 0xbeb60080,
-	0xbeb70080, 0xbeb80080, 0xbeb90080, 0xbeba0080, 0xbebb0080, 0xbebc0080,
-	0xbebd0080, 0xbebe0080, 0xbebf0080, 0xbec00080, 0xbec10080, 0xbec20080,
-	0xbec30080, 0xbec40080, 0xbec50080, 0xbec60080, 0xbec70080, 0xbec80080,
-	0xbec90080, 0xbeca0080, 0xbecb0080, 0xbecc0080, 0xbecd0080, 0xbece0080,
-	0xbecf0080, 0xbed00080, 0xbed10080, 0xbed20080, 0xbed30080, 0xbed40080,
-	0xbed50080, 0xbed60080, 0xbed70080, 0xbed80080, 0xbed90080, 0xbeda0080,
-	0xbedb0080, 0xbedc0080, 0xbedd0080, 0xbede0080, 0xbedf0080, 0xbee00080,
-	0xbee10080, 0xbee20080, 0xbee30080, 0xbee40080, 0xbee50080, 0xbf810000,
+	0xc0410080, 0x00000007, 0xbf8c0000, 0xbf8a0000, 0xbefc0080, 0xbeea0080,
+	0xbeeb0080, 0xbf00f280, 0xbee60080, 0xbee70080, 0xbee80080, 0xbee90080,
+	0xbefe0080, 0xbeff0080, 0xbe880080, 0xbe890080, 0xbe8a0080, 0xbe8b0080,
+	0xbe8c0080, 0xbe8d0080, 0xbe8e0080, 0xbe8f0080, 0xbe900080, 0xbe910080,
+	0xbe920080, 0xbe930080, 0xbe940080, 0xbe950080, 0xbe960080, 0xbe970080,
+	0xbe980080, 0xbe990080, 0xbe9a0080, 0xbe9b0080, 0xbe9c0080, 0xbe9d0080,
+	0xbe9e0080, 0xbe9f0080, 0xbea00080, 0xbea10080, 0xbea20080, 0xbea30080,
+	0xbea40080, 0xbea50080, 0xbea60080, 0xbea70080, 0xbea80080, 0xbea90080,
+	0xbeaa0080, 0xbeab0080, 0xbeac0080, 0xbead0080, 0xbeae0080, 0xbeaf0080,
+	0xbeb00080, 0xbeb10080, 0xbeb20080, 0xbeb30080, 0xbeb40080, 0xbeb50080,
+	0xbeb60080, 0xbeb70080, 0xbeb80080, 0xbeb90080, 0xbeba0080, 0xbebb0080,
+	0xbebc0080, 0xbebd0080, 0xbebe0080, 0xbebf0080, 0xbec00080, 0xbec10080,
+	0xbec20080, 0xbec30080, 0xbec40080, 0xbec50080, 0xbec60080, 0xbec70080,
+	0xbec80080, 0xbec90080, 0xbeca0080, 0xbecb0080, 0xbecc0080, 0xbecd0080,
+	0xbece0080, 0xbecf0080, 0xbed00080, 0xbed10080, 0xbed20080, 0xbed30080,
+	0xbed40080, 0xbed50080, 0xbed60080, 0xbed70080, 0xbed80080, 0xbed90080,
+	0xbeda0080, 0xbedb0080, 0xbedc0080, 0xbedd0080, 0xbede0080, 0xbedf0080,
+	0xbee00080, 0xbee10080, 0xbee20080, 0xbee30080, 0xbee40080, 0xbee50080,
+	0xbf810000
 };
 
 const struct soc15_reg_entry sgpr112_init_regs_aldebaran[] = { @@ -263,22 +265,23 @@ static const u32 sgpr96_init_compute_shader_aldebaran[] = {
 	0x9209a805, 0x920a8a04, 0x81080908, 0x81080a08, 0x81080308, 0x8e078208,
 	0x81078407, 0xc0410080, 0x00000007, 0xbf8c0000, 0xbf8e003f, 0xc0030200,
 	0x00000000, 0xbf8c0000, 0xbf06ff08, 0xdeadbeaf, 0xbf84fff9, 0x81028102,
-	0xc0410080, 0x00000007, 0xbf8c0000, 0xbefc0080, 0xbeea0080, 0xbeeb0080,
-	0xbf00f280, 0xbee60080, 0xbee70080, 0xbee80080, 0xbee90080, 0xbefe0080,
-	0xbeff0080, 0xbe880080, 0xbe890080, 0xbe8a0080, 0xbe8b0080, 0xbe8c0080,
-	0xbe8d0080, 0xbe8e0080, 0xbe8f0080, 0xbe900080, 0xbe910080, 0xbe920080,
-	0xbe930080, 0xbe940080, 0xbe950080, 0xbe960080, 0xbe970080, 0xbe980080,
-	0xbe990080, 0xbe9a0080, 0xbe9b0080, 0xbe9c0080, 0xbe9d0080, 0xbe9e0080,
-	0xbe9f0080, 0xbea00080, 0xbea10080, 0xbea20080, 0xbea30080, 0xbea40080,
-	0xbea50080, 0xbea60080, 0xbea70080, 0xbea80080, 0xbea90080, 0xbeaa0080,
-	0xbeab0080, 0xbeac0080, 0xbead0080, 0xbeae0080, 0xbeaf0080, 0xbeb00080,
-	0xbeb10080, 0xbeb20080, 0xbeb30080, 0xbeb40080, 0xbeb50080, 0xbeb60080,
-	0xbeb70080, 0xbeb80080, 0xbeb90080, 0xbeba0080, 0xbebb0080, 0xbebc0080,
-	0xbebd0080, 0xbebe0080, 0xbebf0080, 0xbec00080, 0xbec10080, 0xbec20080,
-	0xbec30080, 0xbec40080, 0xbec50080, 0xbec60080, 0xbec70080, 0xbec80080,
-	0xbec90080, 0xbeca0080, 0xbecb0080, 0xbecc0080, 0xbecd0080, 0xbece0080,
-	0xbecf0080, 0xbed00080, 0xbed10080, 0xbed20080, 0xbed30080, 0xbed40080,
-	0xbed50080, 0xbed60080, 0xbed70080, 0xbed80080, 0xbed90080, 0xbf810000,
+	0xc0410080, 0x00000007, 0xbf8c0000, 0xbf8a0000, 0xbefc0080, 0xbeea0080,
+	0xbeeb0080, 0xbf00f280, 0xbee60080, 0xbee70080, 0xbee80080, 0xbee90080,
+	0xbefe0080, 0xbeff0080, 0xbe880080, 0xbe890080, 0xbe8a0080, 0xbe8b0080,
+	0xbe8c0080, 0xbe8d0080, 0xbe8e0080, 0xbe8f0080, 0xbe900080, 0xbe910080,
+	0xbe920080, 0xbe930080, 0xbe940080, 0xbe950080, 0xbe960080, 0xbe970080,
+	0xbe980080, 0xbe990080, 0xbe9a0080, 0xbe9b0080, 0xbe9c0080, 0xbe9d0080,
+	0xbe9e0080, 0xbe9f0080, 0xbea00080, 0xbea10080, 0xbea20080, 0xbea30080,
+	0xbea40080, 0xbea50080, 0xbea60080, 0xbea70080, 0xbea80080, 0xbea90080,
+	0xbeaa0080, 0xbeab0080, 0xbeac0080, 0xbead0080, 0xbeae0080, 0xbeaf0080,
+	0xbeb00080, 0xbeb10080, 0xbeb20080, 0xbeb30080, 0xbeb40080, 0xbeb50080,
+	0xbeb60080, 0xbeb70080, 0xbeb80080, 0xbeb90080, 0xbeba0080, 0xbebb0080,
+	0xbebc0080, 0xbebd0080, 0xbebe0080, 0xbebf0080, 0xbec00080, 0xbec10080,
+	0xbec20080, 0xbec30080, 0xbec40080, 0xbec50080, 0xbec60080, 0xbec70080,
+	0xbec80080, 0xbec90080, 0xbeca0080, 0xbecb0080, 0xbecc0080, 0xbecd0080,
+	0xbece0080, 0xbecf0080, 0xbed00080, 0xbed10080, 0xbed20080, 0xbed30080,
+	0xbed40080, 0xbed50080, 0xbed60080, 0xbed70080, 0xbed80080, 0xbed90080,
+	0xbf810000,
 };
 
 const struct soc15_reg_entry sgpr96_init_regs_aldebaran[] = { @@ -307,7 +310,9 @@ const struct soc15_reg_entry sgpr96_init_regs_aldebaran[] = {  static const u32 sgpr64_init_compute_shader_aldebaran[] = {
 	0xb8840904, 0xb8851a04, 0xb8861344, 0xb8831804, 0x9208ff06, 0x00000280,
 	0x9209a805, 0x920a8a04, 0x81080908, 0x81080a08, 0x81080308, 0x8e078208,
-	0x81078407, 0xc0410080, 0x00000007, 0xbf8c0000, 0xbefc0080, 0xbeea0080,
+	0x81078407, 0xc0410080, 0x00000007, 0xbf8c0000, 0xbf8e003f, 0xc0030200,
+	0x00000000, 0xbf8c0000, 0xbf06ff08, 0xdeadbeaf, 0xbf84fff9, 0x81028102,
+	0xc0410080, 0x00000007, 0xbf8c0000, 0xbf8a0000, 0xbefc0080, 
+0xbeea0080,
 	0xbeeb0080, 0xbf00f280, 0xbee60080, 0xbee70080, 0xbee80080, 0xbee90080,
 	0xbefe0080, 0xbeff0080, 0xbe880080, 0xbe890080, 0xbe8a0080, 0xbe8b0080,
 	0xbe8c0080, 0xbe8d0080, 0xbe8e0080, 0xbe8f0080, 0xbe900080, 0xbe910080, @@ -586,19 +591,22 @@ static int gfx_v9_4_2_do_sgprs_init(struct amdgpu_device *adev)
 		goto disp1_failed;
 	}
 
-	r = dma_fence_wait(fences[2], false);
-	if (r) {
-		dev_err(adev->dev, "timeout to clear first 256 sgprs\n");
-		goto disp2_failed;
-	}
-
 	r = gfx_v9_4_2_wait_for_waves_assigned(adev,
 			&wb_ib.ptr[1], 0b1111,
 			pattern[2],
 			adev->gfx.cu_info.number * SIMD_ID_MAX * 4,
-			false);
+			true);
 	if (r) {
 		dev_err(adev->dev, "wave coverage failed when clear first 256 sgprs\n");
+		wb_ib.ptr[0] = 0xdeadbeaf; /* stop waves */
+		goto disp2_failed;
+	}
+
+	wb_ib.ptr[0] = 0xdeadbeaf; /* stop waves */
+
+	r = dma_fence_wait(fences[2], false);
+	if (r) {
+		dev_err(adev->dev, "timeout to clear first 256 sgprs\n");
 		goto disp2_failed;
 	}
 
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
