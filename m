Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040CCC4363F
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A318361417
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A318361417
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFCA26EC69;
	Wed, 12 May 2021 17:31:23 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB3CF6EC5E
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:31:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQdzd5TQrOrqGaEUnhrt3Rtihfz9JW9yc8FXANdrIM9pVdXGU/WduYuIhCH9WEgCzjKZjtxREOlqxoBXJzcz5M1DrZWmxRhtxaVxT1+2VpeL7M77fUmIP28Hxae61YFRTzAZ2/6qV1TemViohAtQBz1GF1imckRdc5CeWO9BWVIGXYB4qKANEv528mac4+SmqLW4BeYp+WZqfXqavrPP+NkQWsvS65Xag/YmpXd2g7vQd9TqGmsCdzfOrlL35k+PS4TaDA5TBpbkbBHLq4WZDMh+3U8mqaW8+uE7T1q8Jcv0C/wU29hn+LV+J3EMALGEUkD+PluoDyNyVYtle+4MYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgoIH33tof8uMcvVlpPfiAFg3n+/c2Ii51heXQ46NQs=;
 b=HBISiEUvUbSduc41/KWVHiiPkE1cCIKHTCfQc5hXBIw4cDaI9gLm6JkR+p8G+tgI5oSNA2LbPYogoGubvtvj/1z1SwjDh00pA7sIpMrQvWVC896DNNgypHnnD6ZF1cwnozBOPWX3Rg5PtQT3NrVxpgXB6WYohP6Id3iPGXfxJzYtOYGjkMhMxLirZ3zl1BYB6hJ2lf9RTkbtrPwrWdafEQNY3ebWfLmCC9dgyamhyAMInmHKlzp+hX30vXOdcmzr6xIVU9jPooH3Zu5EXynq9gea+cyyC+XGfNqTXjIo+uljqCF3s0J/vKPF8kiT5oTFXokM3hNXrFjgN3Y0Plpk/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgoIH33tof8uMcvVlpPfiAFg3n+/c2Ii51heXQ46NQs=;
 b=vZEAGnZmMsLzj3tvbh5GDES6ENL2yA0RDbQNVH9So2SheWFAbiId1i7nlKjDxIzLfLzitRtTjP74wuT27a1T8dIg4iqHBua5cDNE3Y+wFd1Gu41p0V3KidfN/1Abkov5eeFMMt4JJ/exbCIJqj3X0XHLID8t52KXe8Ar2vtW6PY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 12 May
 2021 17:31:19 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:31:19 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/49] drm/amd/amdgpu: add gmc ip block for beige_goby
Date: Wed, 12 May 2021 13:30:15 -0400
Message-Id: <20210512173053.2347842-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512173053.2347842-1-alexander.deucher@amd.com>
References: <20210512173053.2347842-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 12 May 2021 17:31:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34ae12ce-81d0-4f0d-5505-08d9156bc0e9
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2370D93F397DE4D390D99E10F7529@BL0PR12MB2370.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3CzNVH85r21pmyCQczPo/4BA5fX5JDKeLnR+GGohT1MfRTnBSEVvqz+VUp6ipTEtglN1zuVX+fNwB26AACqz+lc63yOG4zKjjRJSGkfRi/FXyBozIAl0J1l+kYfhdKojthpdLcMMRCF980AgSY6HxoRPVTsHMXTr7pgmvge75uxqTKu4gxLt6HVAvJGUfd4fbiImQgp+D8EY2ehXMXOaWnXhJ+pUkpmjPSqMNvujDR7iwRre+ajCt7X3Hpc9uFxwZgpDOT/XA4RksxCSZDQwT1k6G+GI4eFrOMcxDGFl58nV9s7Odgo3+NgHSTdFWjxZ51sBONGU5tqug3Mr0NV6t1KpSMk29S2jL77h08QV1/N/8YbUhI7YHkI1b/kgBrSlTRFRFJeO64F6OXTQ4N7X1AO1UGtGZ7WpWcqXAbsfww220EjGl6FPcbEZuPgpI5yjcqJQCY6u4lu/iiT6hfjVe+hofms+O/oXrRwhFy1ZHnaKAdeTFn21YTyjDzo2OrB58PG8f6GgaHDwFYQ5F0Yy9DFGHePt0lZYvYjv6JRxrygL1ZbYqEHgwocI7lyk+9Y2Q8sJYnL1LAbBqXyC5YX3dETIWDcAwo+kSTbCtnYL7X2PJ8Lhw7ldwWbFIUIcouyMJaizzh17pITwvPMhHUedNqSrVSrYKg8pG4RW/OtEZKOb3k4EqGWZwzdvkGm9gw0y
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(2616005)(956004)(6512007)(26005)(1076003)(66946007)(4326008)(8676002)(478600001)(316002)(54906003)(66476007)(2906002)(8936002)(83380400001)(6916009)(52116002)(6506007)(186003)(6666004)(16526019)(66556008)(36756003)(38350700002)(6486002)(86362001)(38100700002)(5660300002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2oIhnzPY8TUdK6cfly0SE9LT0qHsXuyn0DxVsqI/sAD9Safunry/KCrpOaBG?=
 =?us-ascii?Q?+ft7xZbAbubyN6PtR+ji/w25YwbQnSsV2fr4lRUDPt6ng1tr1oDE3zBj4o6z?=
 =?us-ascii?Q?tLNjdWFydJ78OTfRvnaMJfPgy2u1zGNWOa8gI0BSx5UNfrlAe26lHTmI+DcW?=
 =?us-ascii?Q?lZUMvqJrV0buUZ6oLl+psLkP6qmpQbqK5Bmq2j6rt18JlyKEdgFnhN2NZMO/?=
 =?us-ascii?Q?o0j9S0NvLWGHBN74iLa4KI7u8xiut33ywFu+lYqZsYhB7KuwHhrfEQoUBWqX?=
 =?us-ascii?Q?H5keRiQb7G2MtvzwRu6EbcDOhuWMBcAEQBZg6kqI7Ir6QAx07AmaRRqJ5IcJ?=
 =?us-ascii?Q?OyE+yjXNYIq48Nj4sUjkLs5N7zipYeN3XEj16w5pUWtEIPClGSbnMlPKp4mG?=
 =?us-ascii?Q?6qMrbkScc3aIS17EnuXpweAZPNIKzR840stCpmp09KZzq0fPRpvOy/Q0MMC/?=
 =?us-ascii?Q?Zz2J9vcXkW7Ka4IA/bYV0Bfz39jq875SIGHmegqF+Zlr/s74fGDLIE5Nv17g?=
 =?us-ascii?Q?ZxgtaWca2k2FtbLKrh9+HBUtLsAf5DT00brWhmC0FwIbsKm4FDDQrbfs1U5b?=
 =?us-ascii?Q?PRGNwMBfCPyOoq+vtV/2vPK2/dRI+sE95c1CqdEXjYIMldXmtxAgkt2JxD8K?=
 =?us-ascii?Q?vcgLGguM8fwT+8GjYqtrR0zldgL8wVAzMpszNvri4B4oXNy5NRNOrOZWa46Q?=
 =?us-ascii?Q?DD9UHXnzFJFYFsxRpDpAQnaf+sEK8Z0WkKP5shTQqB2z4nSDLT1fgFuNV0FL?=
 =?us-ascii?Q?s32RfxANg4ejgq/VXMPuErC73kCu9RlxVfdMjHuuFuys0EWV92apl2QuAnCp?=
 =?us-ascii?Q?M13zVD1mZHSjHoM0LaDfEi6ZYWSJPZdbPLYnL4TSsAUdAfUInwxdfL/siRcI?=
 =?us-ascii?Q?8JB27OV+0XZ2EkuxvxFmYWb0PfYBDj2pb+ge6JzKbCjL3UGvzjuvA/KD8D12?=
 =?us-ascii?Q?ofJGJ7nVGJBJR1jTSD3pXF/6WrM6H//fvOwPkRakPn3g5VoV6o0cvPuXXbwE?=
 =?us-ascii?Q?VNoDZf9QG+nTMiOilFDGH6Y13UM0fnmvqBQ8s4IsGRwp+VN7auvodEHiU3dH?=
 =?us-ascii?Q?8wpMk6HFns1ADTmNbwqmFh6pe31ekJABCOhH7kHkJ2qLMup6q8ki344wBc+x?=
 =?us-ascii?Q?zP5x2CzpXyYHOI9p/SiYnv9mM4ahls++UjkD+oPh3h0tB3mM4c9NxYDu3Ofb?=
 =?us-ascii?Q?PzIuOt2D/doLYfbwvI3SdrzKufDINpNDNVdUz7IV6xa+IQHL20SKzIesDMjp?=
 =?us-ascii?Q?dOsclO2bkdf7kIQubgIYy1KDE85sTM+Ypa7bvg7ts3YjbnPGGuUNPClISAjB?=
 =?us-ascii?Q?1JEJ7L2Tz0UJWqmKkWPLEAhz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ae12ce-81d0-4f0d-5505-08d9156bc0e9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:19.3111 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /moQiGig0xknfGUIJImhqBhKbbaZPi3c3+djw03oU55eNlFrelSUj4EbQ7+cnTwGKxRqr8S8yBO2VFwjUWunZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2370
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Chengming Gui <Jack.Gui@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chengming Gui <Jack.Gui@amd.com>

Enable gmc block for beige_goby, same as sienna_cichlid

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 1 +
 drivers/gpu/drm/amd/amdgpu/nv.c        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index cd28fcb247a3..aab19909ec32 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -681,6 +681,7 @@ static void gmc_v10_0_set_gfxhub_funcs(struct amdgpu_device *adev)
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_BEIGE_GOBY:
 		adev->gfxhub.funcs = &gfxhub_v2_1_funcs;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 2ed7f26023bb..316d9583d813 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -847,6 +847,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case CHIP_BEIGE_GOBY:
 		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
+		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
 		break;
 	default:
 		return -EINVAL;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
