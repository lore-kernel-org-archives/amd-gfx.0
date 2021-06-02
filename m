Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECC0C47083
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4295561C46
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4295561C46
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B73466EDAB;
	Wed,  2 Jun 2021 16:50:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0DBA6EDA8
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:50:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7r/rQuQgg52l6alP6KaNUknQlN2lcQL9U9/JJfzq9PQVsZg55Afiyp6SNgf1bd4pGdio35I+o32tMKErRrCI+7IvuVWweI/7AHy3DOlTKinR0jnilCQbQ5UWo7JYqrMoDz6S59De7LQ3UTSYbSZOwy48WisaoP4fY3ORFiRajhWZjDMxQ1HUlFiILjIK0G+WmCVBuO7m2VACKBNENb4fo36W5McuGBt82NqgCf6yFsj1AOFX8X+P/I8qiT8djIXFyiZa+8Jza3jdtKjtmJx5YHmxgNcNlChUUacFGWFDHOy2OwWTM0JMevAe87T7kBOKlZl4Czi9Mptgh6MsmTQaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTLINC/A5e77y15aRKworlqXOAR1p3SWsZqggK+9gY0=;
 b=ZkCo4cCRcvYUyq6kxUcilc/E4CnpQz1Da4JoEGsNADaDJo1K4hv05cLApSLgpKWeLcyVjQAY+EoafzdC7W76/o3XXCfxo0IxXb4CYFJokS2lSG5pyrA9WQADj5ZR0AzQL7iEF8wmibIP1wESaFQlJSzXmnsW/rdNsTyaS500hG0OVA6lTuSwKMYTZd5I/UdTffBG5s55P6jgjfAzDoNFKcOO37M36YKRUvx7ashAeyPfgqvvNLL4aJDoD6mumuZwJkfcEGA+t/9Te5DDTPwoRU66aMHlHgER4nvHr9NBsno6l3Rh1AL0C9gusjrG57mMOboCVvcyUFoDBL4esC1ucw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTLINC/A5e77y15aRKworlqXOAR1p3SWsZqggK+9gY0=;
 b=yR6PdYAXEkbWMcNmuLO8yrQvqOlOTtEnho3am/v6kYTgnuKmxm8vNFMTt9mfvPdzeFeaPiQRBGBnynpnlBe9uYCNIuURY0i7ynguGOzQFeDa0SEtjf4gMSVVXC7bdWqZ+/4Gis5z8teoAQLc9ZzcPzz8TQziLXLE46H6BtAzn8c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4675.namprd12.prod.outlook.com (2603:10b6:207:35::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 16:50:31 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:50:31 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 43/89] drm/amdgpu: enable vcn/jpeg on yellow carp
Date: Wed,  2 Jun 2021 12:48:22 -0400
Message-Id: <20210602164908.2848791-43-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:49:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8987a112-d25e-45e1-fc13-08d925e674d5
X-MS-TrafficTypeDiagnostic: BL0PR12MB4675:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4675EF545DBF4D7EE82C7B8AF73D9@BL0PR12MB4675.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:252;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XQ2hPaaVFqXBy4J76CbtsvBkAIYLk7K7UuE3yFyXZHPFL4lLgUrfQ5kAvMHRrPz5oDCL3RbGywMIq3v9uaelMAbwTVcqBF0PsXgRH4iSm2DmvUpEt1MJVOR3cd2jZS2vVcqH1BCnhffdtw0+KGIrNf/DWTE6ogWKIpwlwxr81sKMDj/49gy+o1wO42M2W9LPXKxeOPp1Qj3iAaO7BUMIuj6tp2Sa2cPYBVF5Fv2xygHh7rgyI20xjot6+B2XxKRpID4erPmHHG/wa/z8PoAzmUbn89S/46TK1EaC/zEEVg3DIzmMepn0rhbMk+Dy8ctpMaapqH6CAo5+5qH0EgaWoYqhZbqrEfFWjaArq7Y6BPlG7ljlQ4h/+kAk7l4CshXvJwM2je5GkO+SqGFQCkFq8iE8R+NzPIh5rQsSO6KH3xOZtG98WDNOw58B9Nqrhn2/PTWob/QkgiDrFVJ0l5ZanbC/fCxoDLQ1O1ZibgNLfbYUIJUijTVTtDxkjWdBbXBxir+Pb1s4n0vAa0oAWDsY+b6CxfekRpVUQnLhBDny8dJfnq/zW5wjVxV8BMDhkr92LU4BxFO5HEmr67ENzVAJftySfJ2cgAcwrn8VBg0Sp1NkqOG5bo33+7pYtayvdoLWtl/+UL+EfuOy0Fp6+F1hNVsoXBmYo9UIl0FwhxwSRytyT0T3zDCbjIa8qP++Bmty
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(52116002)(6486002)(956004)(6666004)(26005)(5660300002)(6506007)(2616005)(36756003)(4744005)(6512007)(478600001)(38350700002)(66476007)(66556008)(83380400001)(8676002)(2906002)(4326008)(86362001)(1076003)(16526019)(316002)(186003)(54906003)(6916009)(66946007)(38100700002)(8936002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?IDQcub0V5XEGBlCAI8CASAMQ4zWPWQFpyVqoHHYyaUsoSlD58T1eM+cqH5FB?=
 =?us-ascii?Q?4FQUE8aFxqFo98xJDYxPhMEfehagcgMGMWSeZbHT/iVF/9Gat4XqNqiBO7CI?=
 =?us-ascii?Q?ZdQVMHQO08Y1XxneabwpaXGi/kmdDsC8aBS2FkIKJSvCNV2XtZC4gsTXju6P?=
 =?us-ascii?Q?vRAb3NyvfwRlexyXdz8F1Ce+JGU8n4MPM4nSA+MjYvY36GFh+e6tJtA4okji?=
 =?us-ascii?Q?QBZ6PcNzhuEwQu1dpQ5p4dEYwscxU39W3uKxp25B5fY6BUYCpIsQ9/N4E1Fd?=
 =?us-ascii?Q?ZWk14WN0x40e5ilz/1NbNGwEYUyTLg4p73VZMpgsK3cS56y7Hm5bYRd11gos?=
 =?us-ascii?Q?lUuMsi2CJWrVfBSZ6J0taNfqZfG9UMIvbnmjl+HKf3oXcUw/0ZicNnf93Le6?=
 =?us-ascii?Q?kevHhpFishFQlacE+idRSAYjUPCOu5GVg9K46HfIJMl1LfoX47vLgVZcwQlJ?=
 =?us-ascii?Q?oqaDzgUZBMsHdsnZlKYJAduKE8mV6KS0co88liMZmnGxf5/2UsQuiyauEgPS?=
 =?us-ascii?Q?AV35WyfOjGhvsJYY3ry6yniKgWDwljI7TyzxdMkTLbgd94O18JO+rMAo9fLF?=
 =?us-ascii?Q?xwxftWLIeqAplECPcHo7zZvHngFehLhHKm6lItm3lbSIpRIZhiMXg6tu8J5p?=
 =?us-ascii?Q?nGO3kT7sxJbL20p5enGBozhFlQCvz+KYvxHsbMt3Uj7yIG5iPFe8i9HiI6IA?=
 =?us-ascii?Q?aweIXRhor1aUv4q6brO5V94eBl5Y3dvIHaVW1NUPPgaA32RXuEU40uII39CH?=
 =?us-ascii?Q?SrJuKTUyNKlun+S5gJCV/PKf8wyTS5eajVkuEFHx7sas++hQjnp+158cZdp6?=
 =?us-ascii?Q?Hj4+xr2cV1i8zmvfs1/CstZ2FXNjbFmQxJwaHxgQARGYhM4viuZeU8szPe6u?=
 =?us-ascii?Q?IbfP3MWcDimPw56z/3EhWwG61GcC7IDx+TpLJzvspE/CpCaVSkiqf04zUBdB?=
 =?us-ascii?Q?lJ2MM0iSxY3h/ztStgoJk+tUm56Cwh5XagllOmFf129Smu8lpNhmDLg+8Adg?=
 =?us-ascii?Q?8uZID27yKeeJ8jdidRTCnNtg8Hpu2F87OUZGoY+v33ukzS9PudPaFUzRr+SA?=
 =?us-ascii?Q?NyN4SrzZbJ6r0tXwDlorcQxl6gRTXIFvKfxF19/MkWHoBoI8Z8lltrvAIBOX?=
 =?us-ascii?Q?6hnH47fIQ8IbmbNATTYPCXJj1nZTr9RO7f2rjE5qGAAIeR/D5IJgDivgLQp1?=
 =?us-ascii?Q?xG00s9U1vTxI4Ea8paqs+H6l7sLiOj0TEv1zezLYKS5JV7c72OoWa8PW6gVc?=
 =?us-ascii?Q?m75tFb59WePvuJ/CXqNfWFERkZ9qLzEYBrF5edF7/5ZwYoh+kiAmYtKe9Jq1?=
 =?us-ascii?Q?gk736c5Jddycbny4MCmFNJJs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8987a112-d25e-45e1-fc13-08d925e674d5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:58.4274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g7jFHWDREPcN87DRUZzAtNHYdBnK5mWw1YpDyR+cFlcnuENbwAVAB5QVRYuc/+nqWQtWv9RT/GShbH2WiUee2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4675
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 James Zhu <James.Zhu@amd.com>, Leo Liu <leo.liu@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Enable vcn/jpeg IP on yellow carp.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Aaron Liu <aaron.liu@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index fc3ad33b4de6..90e50f90e346 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -999,6 +999,9 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
+
+		amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
+		amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
 		break;
 	default:
 		return -EINVAL;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
