Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA91C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54A2064F03
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A2064F03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA7DD89FAD;
	Wed, 24 Feb 2021 22:19:35 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2045.outbound.protection.outlook.com [40.107.100.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D648F89C7F
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:19:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZeD/5uTVY9YKpCykDjqtaiRapqaJOX+HUtHnyPqRD6r9EZk7sjdupcxzX27GqFd6eMT+HX/5xQ3a5oqu7pcm/zADn9GVIih5PQ8fBRPkhH7/onrcD8s9BUyYryIX3kFZyI9w1hDlop5esz8Cn0hFW3MRBKz2yp3IUbBN1ZJdJmge56UZDqaVoZdYMOx1i+Hm9gI0OhEAc/DBaBRUxa+a8LG6AYGg49vx0uRAaYgWTSQtvsmsFy6JGOHauGYT8QnHx9LUOHBbeAPdWRR6z5mu8T3Eh7OCkxvaLh/rk8y9TtsROsmQWzBFBVK2+9t+iIcMggu9bXhrPe9m2ewQOQCdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVhWffSx1lvqXeQVY+4SxvrX8BIP6mV6Y4OaMOZZ9Oc=;
 b=AlmI2g5mknH0mDMh5KnAlQcqoqgIz0j69bPVgnE6XCCJUYnsRZ0UKg+q0ARpLlRok0E1Qz8+tCIjGfraU+/FK/UJ+/WqgiplsaLH9RBuRbLmgtfDsxkFD01FBlAgm8OLJV3K777GlfDTbWqk0P3DeuuGbrgH/tykgnuO6wi6BqYT8sl8cXrLZU7/QH6jo5ac/Pq1a1Ikuq+jsGCw9Q9q7iTuXLK/kksIANdiOMJz9DNJlJydW65QhDRy2XThEHSqe2E8LqiuvZoNeOzl9gVa8nrwO+bMEzpCqi+Hz7i8h9ARmhGdxmCsvdLTTXPMEnqUQfnp4eGdAuCTIMPCN6l3PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVhWffSx1lvqXeQVY+4SxvrX8BIP6mV6Y4OaMOZZ9Oc=;
 b=I0iu3c2FgmukDnRSaCP+7QAeYKhxXQMPQb9vUuKZ9pfNVUnWdssXwInWedJpZKOybbCJzlHYSocTZWxjBsbj4hsq+fVClGX/RhpcgMPSdbjz9B/N5esfSrF7s0jkFmlsVaSQKdflkmIWfV0fTegvfot7bwwu9g7SjN2F8vM5RS4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:19:26 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:19:26 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 012/159] drm/amdgpu: add gpu_info fw parse support for
 aldebaran
Date: Wed, 24 Feb 2021 17:16:32 -0500
Message-Id: <20210224221859.3068810-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:19:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f3f11c00-966c-4a9e-290b-08d8d9123f24
X-MS-TrafficTypeDiagnostic: MN2PR12MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4175EFBD0C3ECAA42C934411F79F9@MN2PR12MB4175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9B53gHsK4ZFlLihFpOQ9tEBxw9wXVzYvOxZKhm0bM7BF4Ro0YlqzILZWvUo1zdJsl+f9ShIca/Rab6r7hMEdw2TXMpsTvaMcVxMVHSC5oDr3GAsUVesp03Bn/VDC3DuDQNaBwIcPZiUB8b+9jFcu+MxkQmtqGSfhFXZGx13oeWYN9UHn+GtDHLf7XQnK7pXnJZvxFTZZ/sjJL8ono2koAXWbyndfRJnVLtR6OESiz/xc7Lw7EwZsGaOLr2JXk6n7vOrIJp5SSiu89AyFmQUWZYHGsObg4TEGMGP2U9DfavyuXhkO9+eQnOuaFTF67KbP63BqCqIC/+OrhRcOAq80ntumb3ufznTpgCessWRo1mrI56Qc0IG1Xdn8gU1WqllMCG5XPNA36bp3CmuvefLdkZT0XucETuQHhxirmPsfo1GeuN8ETrkcOqYhdx2TBScap2snJnCg7XXIAy9pmzr20WgRxoXil8cW7VQhzXi4en2D6o1qNynMt1IHwhBWGxwam24cQboarMgPiUTlM5f57hWPZLp/e4NJUbX5NYOF3wAMlMjcL4PpfevWHAyuy1DX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(66946007)(5660300002)(4326008)(6512007)(66476007)(6916009)(26005)(36756003)(66556008)(2616005)(186003)(956004)(16526019)(478600001)(8936002)(6506007)(2906002)(69590400012)(86362001)(1076003)(54906003)(6666004)(52116002)(8676002)(6486002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kzooZVGckCYmPotJ9m+hEXIZqLAw+0Ve3LJJpc0I4JhZ9wpW4DJattvMBjpm?=
 =?us-ascii?Q?j0jzNRW69X9bRbLdNvHZs60IAB60Ap/vwngES6vP514XAR5f8syzPxcLaxnZ?=
 =?us-ascii?Q?ZN9UOiwaT/MXGbgcmpH8xhkzfiqjl1boyXy6yw750VWyu7gLj7mSS67H3ok0?=
 =?us-ascii?Q?V5umj4wAQKh3IVCOiH3HnF+N0OS1+jtNVNgBNf0fPQ6IFOcg5pDcD7YcPSjS?=
 =?us-ascii?Q?w0sESoj/XMwdx8neP+2X3njX+eK7mxZ3/xQh/Xc78SqpLapkaCL+5wqSHYBA?=
 =?us-ascii?Q?Adnop0xUdiAAh0eoMlkHREL6x8HHoubfDFHoKx3D38OPtt4klsbC3dqaXYtR?=
 =?us-ascii?Q?jQtabNnyALP5oWZtyVLIbpeEkj2ksW8etlsF1pB5CB7ddIPl+7e1bBhHm9UM?=
 =?us-ascii?Q?sJJyoJs4NpBOxYpSmNQ+averpxcNpDzRbDWkDUHytYJ39qgGRO59q2sgSZql?=
 =?us-ascii?Q?m3p3sqsrVUpPZnNwBNgD8NSgbbMvdnolrOJ4QEnAJ5UcQkH6j0/P4sx2xXHk?=
 =?us-ascii?Q?JypJV+ws3XnzYaFJvaANeLgkyTa19wN9PGeB8ZyYo6ni3xagkenuGycLoye5?=
 =?us-ascii?Q?xlkrcS7wQQlV0iPYvEZ00MH4tH+/cL+U60HgPKs7nDH1drYbKIfaQf3PMaCr?=
 =?us-ascii?Q?8dviGo7N4ad6QABqAIWcllCu1p6i9lKxCbkDNA3TreOdoMB7vo8YljvaNx1u?=
 =?us-ascii?Q?Ib9hKXl4CFt7LpJFmsx0t69wfAoFGvMu5HpZQoFDlkzbn45H045VZ9dMlW17?=
 =?us-ascii?Q?QY4fZURSuTJiqv7MpRzbLRkMr5zv5838TzsCq5sMplZpV0gOr1zpPwBkiXeV?=
 =?us-ascii?Q?5oNtW0cvU0Yr/ZXo0z1jC2EWWAzbPRGqTD93OaJQ2X41eAacr0EjYVQ0MmoT?=
 =?us-ascii?Q?K8IwnnxXaGAJJWW0QEh/fZ/WA4uk1P/ytF4rxGuIGXFAoNVbslZ8fgmAf0Xj?=
 =?us-ascii?Q?vhqEdlgVyxz2XgaSGWe8X8MtQPmTLo1I+l+I5qLMwoDHgfeXoRbYJMyplIez?=
 =?us-ascii?Q?/jPzZ4YIQGgZTz52Sv1gmx+rm6swoSvyEdxyi6SNV+V2QWDwofdPBBIOvNGs?=
 =?us-ascii?Q?lE8/3yKxTpJD0djRjn8+CeNeEw/wlfIvZzKP06n5IkCSDEk+BiGoMNhFMSUf?=
 =?us-ascii?Q?0G5tV0bNh6VbvH3gku3RcjEyaa1oUHFZyeYFL/nJ/9fSlj4tvJl+pyYI24Xo?=
 =?us-ascii?Q?BDhfWYd9VMSEQY5CgyM2RxSv9NxOGvds7kDEZwVWoITbyV3ZbtSbXLqxTTmH?=
 =?us-ascii?Q?OkYLKnPu93C/pyFD1+AjDOLtuUKZFPLza68YM1vV6XF9XAZoQgxGobNqxS16?=
 =?us-ascii?Q?xSwcCqVJVMkZY74sKJ4zuqTG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f11c00-966c-4a9e-290b-08d8d9123f24
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:26.7317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XDNGa/COFAcCZXwOWFMm3TfBbNLEKBFdilJfDKvnoz4eyec7YF3C9Pl0q/PzFTFOpWWc+wNwSKqH40OX6Z/3uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Evan Quan <evan.quan@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Parses asic configurations stored in gpu_info firmware and make them available
for driver to use.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Acked-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 801bc1c31c43..7c7a6431f92e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -77,6 +77,7 @@ MODULE_FIRMWARE("amdgpu/picasso_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/raven2_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/arcturus_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/renoir_gpu_info.bin");
+MODULE_FIRMWARE("amdgpu/aldebaran_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/navi10_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/navi14_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
@@ -1837,6 +1838,9 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 		else
 			chip_name = "green_sardine";
 		break;
+	case CHIP_ALDEBARAN:
+		chip_name = "aldebaran";
+		break;
 	case CHIP_NAVI10:
 		chip_name = "navi10";
 		break;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
