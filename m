Return-Path: <SRS0=V/Q8=BI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7EAC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 02:56:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78E9220663
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 02:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PP2y5b2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78E9220663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF1FE6E433;
	Wed, 29 Jul 2020 02:56:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA3D46E433
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 02:56:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bO3/6y9VDWK4tzlfAL+nftyb59YKDhi2XyWipg4Hv0ue4tetdJPxuJpY7pyGpqFNlredvcDrIh6jokBN9cdVKe7IOIlRqHS2SCVh6TS28Lajwmn8k+CZGIdkcgGnQHD2wBQMIUo50pkCYJGr6GvLJTmSbbQ/C4G9/j0lBZUS/w1Eclg9kiMx2IeNvTWQ3XUCqprIw6oDndZZdgMr0vdGr6QbOx8Xa2FowF+6HUuletm3ShTToHeLB2DxD8R7IZtkuQUZoWQlg5JiA8+JnaD4taTOVQhAxH7XAxoH4x2xnJjQHxUZ+aazQ1NdUkxIMY4dOPR3w1hfq2nJQoMT8a/YYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQzFD7WlZCtS/G3ihV4qSHDIYk3Ebsb36ZOuNwcRSgc=;
 b=A94C6mOdRCSB2Zz23dE4QybRvQsFx4dcyrFkccE1AktjcGa1HdvJqN6EvbfmsTM4XXxpkcAeQHIiGJcE6D8AgH+kIISmua9XnvMt0/Yc7Iho0yf2C3uITyavQRJ7ilD9WmioIpc3+3FTTBRnlTjvX7t3KaWlyVDvg29r641sec8EvX+45n3Sp5jHCHj+tRrfnDkNqQ4gTa4sLsw7feloxXudugbJoyIDEPUemdgx9fElJD5g2bVWJmYinQNrEoopQ90BzEqXslxnjDhpmS2CJSecdyWB0yYh0avYtQIYwvC/U6uQx1ctOn0GEIk7+NnFAu+tRjSR41QwxX13/p2Qjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQzFD7WlZCtS/G3ihV4qSHDIYk3Ebsb36ZOuNwcRSgc=;
 b=PP2y5b2LTHuvZQUMXXo5S2UEXBTR6KZd9C41dtdxrcoAjw0yTAS+7EWhZwDClXw0TNYXr2vRQUxiopbrCnITc+kNR6Wlihq/sx0QHXFjeRbvdWZqWHYyEN7devpWqFBGGfmPvqFE/F4Am8eJrol7blfVAsPZInsd9wa0j+UCm7o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1285.namprd12.prod.outlook.com (2603:10b6:903:3e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Wed, 29 Jul
 2020 02:56:53 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.033; Wed, 29 Jul
 2020 02:56:53 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, andrey.grodzovsky@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, lijo.lazar@amd.com,
 christian.koenig@amd.com
Subject: [PATCH 00/12] BAD GPU retirement policy by total bad pages
Date: Wed, 29 Jul 2020 10:56:17 +0800
Message-Id: <20200729025629.19355-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK0PR01CA0066.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::30) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK0PR01CA0066.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Wed, 29 Jul 2020 02:56:50 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3542bedf-7aaf-48ee-85e5-08d8336b0bfe
X-MS-TrafficTypeDiagnostic: CY4PR12MB1285:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB12853FAE9E975B92C4E9515BF1700@CY4PR12MB1285.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z1x28fv83cAZtfacAjLC1lSowdaB7uDf8fdLw2Um0oGcEr0p4x2qIqINia9KgOXqiBnrPM283/+2YzNW9RwNMOal5x78HQ4B0bguGJOYp6HTDLMvFpKEVX0296rH5w8iO5Fk9lIoRVU41KRVT9UMEbGlDK/d694I2dP7xsCALGn9D9RR63epWTo5l65o7UOtigEqXhXQ2Rp/hnrdmTGw3hDS6NVWLI4M32YgKrbsxmaK4X6efy3Vhh/q13uZm7A2ZGKj8J08I6Smxw+5HVtWGcSS3FAd/h+v9O7n0QUxyKgZmQrVXlRDWY2SUlUY5pc1WTr/dmzxvuvLLhis0kABLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(26005)(2906002)(66946007)(6636002)(52116002)(66556008)(8676002)(86362001)(66476007)(186003)(7696005)(16526019)(6666004)(44832011)(36756003)(5660300002)(4326008)(1076003)(316002)(8936002)(956004)(83380400001)(6486002)(478600001)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: hJBvz9dUDD7fW5IAiLPbxssS53IIgD5/9xS2iS0AB3nzOgJxrpD9vsvC6gtLEkS/WevT0WxJZS4Sp59LCVwj3pk0QNeZPsbE6EpQ5xP9SrLaWETBpt+kKHZhAd0sQiwcJavFxf5qGVCJajWFVr1KID0uw3+2i6yheZCK+vpoxk+MqAZhWBWWkqh/aFceUVouZJQtQOgkU/uwsHC4YqKkYhR+vxmuG0m33H5xZEnDEJK9cayB3YtocIO5kw8WKDiPsv5WnIgyyrVXQpoIeqAxXcMHMjhAFnfe991py/XJc+7cfuZ/knSWUM/7nxMoMwlFFqmQ2reZyVBJPXYesKS6fPux8g9M0Lvs5umf8ptAK/7lgBw//dmNbQSFC9aNr0YDrN1+IlWe88My1WvfJMkFsvzzeJ+2ttKKORblQVZinItdFEj5kO2PBpY2mtOUm7DllQk0Mq1/zByFS+k0MnCvusPAc8+WK1hA33Q++L5WzYoZvTVno6cBotagR7+dJk22
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3542bedf-7aaf-48ee-85e5-08d8336b0bfe
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 02:56:53.1131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pE3KWCEoUWqPy/PJs1T6iNYYgyt/yHZgL1bBskh0ZS55bMgIM5C/Fns3aZubSyx70En6qhy++mBmZg0nmTsTyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1285
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The series is to enable/disable bad page feature and apply different
bad page reservation strategy by different bad page threshold
configurations.

When the saved bad pages written to eeprom reach the threshold,
one ras recovery will be issued immediately and the recovery will
fail to tell user that the GPU is BAD and needs to be retired for
further check or setting one valid bigger threshold value in next
driver's probe to skip corresponding check.

During bootup, similar bad page threshold check is conducted as
well when eeprom get initialized, and it will possibly break boot
up for user's awareness.

When user sets bad_page_threshold=0 once probing driver, bad page
retirement feature is completely disabled, and driver has no chance to
process bad page information record and write it to eeprom.

Guchun Chen (12):
  drm/amdgpu: add bad page count threshold in module parameter
  drm/amdgpu: validate bad page threshold in ras
  drm/amdgpu: add bad gpu tag definition
  drm/amdgpu: break driver init process when it's bad GPU
  drm/amdgpu: skip bad page reservation once issuing from eeprom write
  drm/amdgpu: schedule ras recovery when reaching bad page threshold
  drm/amdgpu: break GPU recovery once it's in bad state
  drm/amdgpu: restore ras flags when user resets eeprom
  drm/amdgpu: add one definition for RAS's sysfs/debugfs name
  drm/amdgpu: decouple sysfs creating of bad page node
  drm/amdgpu: disable page reservation when amdgpu_bad_page_threshold =
    0
  drm/amdgpu: update eeprom once specifying one bigger threshold

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  32 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  11 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 186 ++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  19 +-
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 121 +++++++++++-
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |   5 +-
 8 files changed, 331 insertions(+), 53 deletions(-)

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
