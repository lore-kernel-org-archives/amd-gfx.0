Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30AEC433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 02:58:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9374E6527C
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 02:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9374E6527C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29E426E3EC;
	Tue,  9 Mar 2021 02:58:47 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F4696E3EC
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 02:58:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fp0Q+03pj05QukM46Eu8FK4GQpdv7WOrko4ruR2SSI/ub7pDzvM7HFlelbK/Gn9mae5oFw+2D2KOCNQ/CeKhYf1R3pqAPI4vGpqCr7x9lj466YvAt9obTvugouC6ceq7DgfxaK2cDEoEyL1W40ijBtLFWxeuxwJk6uJAPZugfrDYq4/RfIUqQpcr/I+DjtI9D1/nIvIuFHfb85iV1+jlYwdHxzTW3qS9KXBWYpGdEyUWItwxQSUFjvqALf0/6coY1eg67v+lfP8+rOVXPtzW4aNDpkwcnqqlz/OGI2VRwwwD07hD52UT6YkT/7OSodHJtr7eH7LsnnO8FzUXZIbv6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKrdgmMYJ85gBW5qrR47ojWAlfe5L0DAs2oxnGM2dYo=;
 b=i52o9Csp+97e4w5jjSQpm0Of/xgzGMql/z7f688GpyrI83Erm5lGSRnqJ79HMINQ3xkXBg392JELSXdZqV1tEMVCbxz9j7jfHVkm63E+FtZqhyMH6z9rHNXj9sJze330B4vChqr+b+tNqkG2ajlQfwgSI+w/FKk21fUi91tStjHRqT7uILPX4jBOgitYDUwvstUuOpLw9+ro4ZgvLXU2/MGnVNrvI6Fwzvzbu8vnWSFehgcgmX+nkixUUIpR0R91GptmQXBvgMhhCpSKq+iGUoiQd5L/ye+iyTLkncGYx3wF8HLtEbepl5CABMo8pu7+LXo/dqJSpHLiUlMkigqH8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKrdgmMYJ85gBW5qrR47ojWAlfe5L0DAs2oxnGM2dYo=;
 b=hW4niGWhVXohDzIbo29HhXMoU/jVULKzUuVx6QUojMJiqK0F2fkjX+Pndj32qv0LHx9x2IDFCnswfbj9GuZCfdTmgOX1AftimyuizXjWxZ41WR8CMeeZtvIDBHI+VOz+nmXa9z/XR8sePawRDUo3o7p+F0DNTLcL6RYW3cRGeLo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) by
 DM6PR12MB3740.namprd12.prod.outlook.com (2603:10b6:5:1c3::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.20; Tue, 9 Mar 2021 02:58:43 +0000
Received: from DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::1490:780f:1494:d66]) by DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::1490:780f:1494:d66%3]) with mapi id 15.20.3890.037; Tue, 9 Mar 2021
 02:58:43 +0000
From: Jinzhou Su <Jinzhou.Su@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: update secure display TA header
Date: Tue,  9 Mar 2021 10:58:25 +0800
Message-Id: <20210309025825.1267-1-Jinzhou.Su@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0172.apcprd02.prod.outlook.com
 (2603:1096:201:1f::32) To DM6PR12MB2812.namprd12.prod.outlook.com
 (2603:10b6:5:44::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jinzhosu-System-Product-Name.amd.com (180.167.199.189) by
 HK2PR02CA0172.apcprd02.prod.outlook.com (2603:1096:201:1f::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Tue, 9 Mar 2021 02:58:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 80899f78-f328-403a-7180-08d8e2a73fb6
X-MS-TrafficTypeDiagnostic: DM6PR12MB3740:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB37407AE38591C537EDFB551290929@DM6PR12MB3740.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:51;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2VfN0QHCrq7VEJJbJ6NWXV9Aw5qTmwgKfpqVfU3zki57l3HCKNOYp4e4Yb0Ot6qP/Tb+7hDtmaVmmRIKL9E+CcqNVpaa/UgX2MnTlyL1s3QfJDfX9EzDIBxT1DwWAtL64iodtQWWd7pV6aih2Ie6+0byXPaa32UetfGBEhEL6S11PlIdPcDgxpRVXWUcmxpmOCmQvwOThh/bSJPnx/hdg3lFA/lVVPtTwbVnGAmLBOiedKpkXOIQg3ryds6+8tMv/lx3k+hpl+YMswrQjtGmppjmCu1JgZlYxwyOjVWU+gjEfoJiRwmnQqyRgY3AUs5C1hpoJT6LzflGn9E1VyUitBsTb3FZVNn2M7tBdRFN0unncClO1TDvBVCHYym2emlY1dWMCPJJCFC/Aln+mXW2JWXwYRbOuPvSbALbP9urFyVezhMFqfPN38R3AwhxDQ4sf2+KHHExysu2Aiu2iC/+SJ6toHTK62l2hbS2TEEW+b0lyNy13NSZsvdShg6J1LIag0i1bXQxyI4AxV4EsXhJ1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2812.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(2906002)(7696005)(5660300002)(8936002)(956004)(316002)(8676002)(2616005)(16526019)(15650500001)(83380400001)(186003)(86362001)(6666004)(36756003)(66556008)(66946007)(66476007)(1076003)(478600001)(6916009)(6486002)(4326008)(26005)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kJBOsvcCBlcOwB64QJgm0ddySvxkXDrKF2UCOwhWTaOqE+Gh+4mdwn9ApsRN?=
 =?us-ascii?Q?KUMZ4UPk0ZERVvSpkEjfntxVRAnRE6nx8jtVtsnY0fTE5T+kJYaUnQULq6Rb?=
 =?us-ascii?Q?o0MttyDuzhA6a8UTc9QH29zZ+o8ev2BqL78vfh5Np5uWkjq62R4EhnJU/OyM?=
 =?us-ascii?Q?xh8IOMvMNi9jjNpwoEfDHU+kbpZlZMoFDJ3nyWJXc0PYaza2Jg8k8chyrtAH?=
 =?us-ascii?Q?Q+VUQLcvGJXeyK4l18iONosUErXfxkts4m0Z4c8Wk1yIKeqOuuXM0klKqA0+?=
 =?us-ascii?Q?+j+JhOThLQ1BU7sGv2zrNT3tmy7j4AadPU7wiCwQ/5Thvmc6G80V6SC4SeOA?=
 =?us-ascii?Q?p6DwG+Z7+kdubQNujh/Lb5/8ufc40c76S8l7mQSpOOIgt8HjbuZVHz7POvaR?=
 =?us-ascii?Q?nSHn1kAEzhyaf0p14fETaEBf2QxvIn8CB0FBBpJ9/t5s2hPWiBOgNHegDhqj?=
 =?us-ascii?Q?UYgrvthQ6N5Jq6x/DediCAdGObcvviLwpot96Kxlk9W/cE0cv7p+5Uaq7l/q?=
 =?us-ascii?Q?pS0HG2qMnZLbLN03oEuMVfnbdtSdbpYkfJkc+niLiH+BuCoOs6SWtwF+VHc2?=
 =?us-ascii?Q?kdVzrVn1f7qobzBBJBgFT8WG+uX6mD59T8KXUAbbO0edBDCTk1kP0hCWD5wo?=
 =?us-ascii?Q?P03jUudqQSvyhPmy2Up70dnpq3ihSi1a3yAU8LRul4xmvCUSFZK8OWJQS68f?=
 =?us-ascii?Q?A2UJXdEvCSs4YpR+5osUsjScBLNpBQ5m3WXBqnegAdGYcyqrToMXHxIC5sXY?=
 =?us-ascii?Q?28J6mUa9e5dg7fPiEY2UG1cn/jUFV9VWB197m8V+kVI8OCotLfCqkTBsau5a?=
 =?us-ascii?Q?s6AzyxIzOH2z8yfiLYbhMkW4b8fttx7flQpDPx8V+uk5vUchDagEGm7J/Si5?=
 =?us-ascii?Q?TmwHS5xQfHpX5+padO+lLe7HY92nMvIabQZUJmJFFyxlOc9yUcWd96sDu2Jn?=
 =?us-ascii?Q?n3qBHu9D5zaTD++WvxmZ/YCj/rUBMvXWNoF4ZLtyrS4kWS5MsmeyUY+3sFhY?=
 =?us-ascii?Q?BTgev6N97VvfHIQBS8x3yve/hOICWwkfbcaUdyez9sLH23z4fWGW4ZT9ZdEE?=
 =?us-ascii?Q?oUY0hdP9nd2AbZRCArtwgL50H0Om7bFhBhn3vt4ONCwLgDt3I6uRJN8QnghM?=
 =?us-ascii?Q?XSxGlUqvym/N4Ax6c8eTMJFsAVUXHJsgjsxjQlQqE+nyEcvlhjFw/ZAuBn8e?=
 =?us-ascii?Q?S3iiX8RzrSJiVkWfnbMsvQXetrT3UiJZB+njfR51piJwtF8o/dOyoMGIq/vm?=
 =?us-ascii?Q?pbN0GFnCIWE/MmsE4hlyGNKe2Kkv8TIJBeIgQcy6h8W8ThmpuA0EnoYkK4LB?=
 =?us-ascii?Q?+Dp3KTC6lHOOK24nX+qoOI9A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80899f78-f328-403a-7180-08d8e2a73fb6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2812.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 02:58:43.0581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/TYpvQA2hNfnjtlA7lTY3JmdrykVwyusHopc+85oXxvF4DahbihiOv8J06OKxacwlHJTBqtuoIL4VwqoyYp0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3740
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
Cc: Jinzhou Su <Jinzhou.Su@amd.com>, ray.huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

update secure display TA header file.

Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h  | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
index 834440ab9ff7..9cf856c94f94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
@@ -69,6 +69,9 @@ void psp_securedisplay_parse_resp_status(struct psp_context *psp,
 	case TA_SECUREDISPLAY_STATUS__READ_CRC_ERROR:
 		dev_err(psp->adev->dev, "Secure display: Failed to Read CRC");
 		break;
+	case TA_SECUREDISPLAY_STATUS__I2C_INIT_ERROR:
+		dev_err(psp->adev->dev, "Secure display: Failed to initialize I2C.");
+		break;
 	default:
 		dev_err(psp->adev->dev, "Secure display: Failed to parse status: %d\n", status);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h b/drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h
index 5039375bb1d4..cf8ff064dc72 100644
--- a/drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h
@@ -50,6 +50,7 @@ enum ta_securedisplay_status {
 	TA_SECUREDISPLAY_STATUS__I2C_WRITE_ERROR         = 0x04,         /* Fail to Write to I2C */
 	TA_SECUREDISPLAY_STATUS__READ_DIO_SCRATCH_ERROR  = 0x05, /*Fail Read DIO Scratch Register*/
 	TA_SECUREDISPLAY_STATUS__READ_CRC_ERROR          = 0x06,         /* Fail to Read CRC*/
+	TA_SECUREDISPLAY_STATUS__I2C_INIT_ERROR          = 0x07,     /* Failed to initialize I2C */
 
 	TA_SECUREDISPLAY_STATUS__MAX                     = 0x7FFFFFFF,/* Maximum Value for status*/
 };
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
