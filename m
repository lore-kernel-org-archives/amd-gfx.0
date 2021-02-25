Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F831C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 02:51:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF95064ECB
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 02:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF95064ECB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44A9A6EB7A;
	Thu, 25 Feb 2021 02:51:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 273486EB7A
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 02:51:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5LXAyEC9F3rcTanzpwuNQzLGIAD3GQYKlNyuNHKHB+S5JwQP2HzIey/er0kB8eFun1rTGOHgmmM2Ni30iD6UJf4yKHM0kthYqRsSO1ueV5spTnHJQTTUD77Jt35cPaGPK8dMF9rUDArQ0rF0KWUKX/gkuHgFKpEZ5qXm9Hi5I6APqkPKwHNoXPev056rl1+EWKCNj0vTcbvXERiiAOq/mtnAWrLtqrkTXZ2YkpggWdRD63gUOhpJc3GO+7ng+28wYGpIkTtYiGucXtAW1Sfvfe2lt85GIe6p6BhqCwXP2Dw3CrkUAZdRhFaXyog8H+5jxi8asNQNWqLphagY8ryrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Qt2NxhrS+/csIIs0WAWOhDWuv8PzPLkjbGKxVSEXcE=;
 b=TKVDlb5UCTsT28BW2SKbpIJHMoK3HuGVwESa9Ku5uSwMTHix9rLlo0PGp1IhZDG2pVSksfXdrljQSkLpik7xKPiKO09F80KdzA0yh+nidEqfZTS6Kn46EDb23/+uZnfkeHSnk6qFAyuHWYCUmYDkcPkb7ot9GHOWE1SWbCKt7muz8gVKvLJXbgC4P/bXM/UJx4pHZgWu+8ZUGtZMHbC/VQFEjLN6V36HUuDiFQkJhhPoiR0OY/4sCOvsmD9VOka6dfzZOkcX/5F5l7a/UpukcnbPYFAeqs3MUZO9l9gV7QZW9UF9+dikqNITxuS6qHWQzdhHBd8XWRJtb4pKz+kkLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Qt2NxhrS+/csIIs0WAWOhDWuv8PzPLkjbGKxVSEXcE=;
 b=itOPsa3xWCm1BUvxZ5gi8Z3ms1wsR78q5Wg2su9u7fULmO2uBx+v0KzbsL9f1wOgHmOJNfGypsBNY5WfAfGiZnqAMLKX7MXyNMBL+Mv8ofwNy1xfEk4jRYyTP2nApbkv37q72Wk649aON8Qyjx8WOAnpL6f6BH9kzjZ8sTtWo5o=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1260.namprd12.prod.outlook.com (2603:10b6:3:78::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.28; Thu, 25 Feb 2021 02:51:18 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3868.032; Thu, 25 Feb 2021
 02:51:18 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/swsmu/vangogh: Only use RLCPowerNotify msg for
 disable
Thread-Topic: [PATCH] drm/amdgpu/swsmu/vangogh: Only use RLCPowerNotify msg
 for disable
Thread-Index: AQHXCvJZSenEwR7lgUCerzDcxCkdYKpoLB3Q
Date: Thu, 25 Feb 2021 02:51:18 +0000
Message-ID: <DM6PR12MB2619FFFB1106AC990CAAFDC8E49E9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210224211615.2814913-1-alexander.deucher@amd.com>
In-Reply-To: <20210224211615.2814913-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-02-25T02:51:15Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=3d0230bf-15e6-4da5-93ca-2c7bf0f27248;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: df512be0-1ca6-4398-7253-08d8d93839f7
x-ms-traffictypediagnostic: DM5PR12MB1260:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB12607E6730DD9379C73B0ACFE49E9@DM5PR12MB1260.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:556;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6vwOV0dO+nyIqHh/dX2sdSglCvExtqoWqch1K2lT3p8K+gXf/01DARRYlYkaOK7n+FbtSytS/VcV6iEZLJltBv3+UtdpJPjZeSKJFntLggPyeF+BZ2ezf2YOO90H0H/1jc5BZTTjcoRaC2Bx/u2IHHOosFKQylLgfX/SwE2jKISmLRH4yBpf8yGuVX47xTJepd/awin7RPmPGIolQMIVerZRXFs0vrSj5yNS5V7PiEUKtvMZ0B9bVwSZwh4NNAGhnVELLvH4KNYZ0RbGMGk84fzx55qneA2R/cXWqHuegJL4xFCqq+L5EJYFrXJ3WIL4Y/e8YZGd1GvBKu4XW0dg9GsVympMFK8t4+78rimqCJxA839bdpwWRenCiR+N2at8rLX802eJPMdPYXxu5O1IYg9i+LRAh3Hkiu8DQi8xn+MxqiE5jRs9NK1C5gGcyA9BMoRnRvATlKVdOiKDwm1JNtGos+Hc9p3jzEtnufu6WzGT9ejpW3y/9IcUyek9jtSIbHSYipmerFoKdfUQOYDyKvaaWwUeyK8dHnH1LkY22L2rrNoK+uk6PLnscujzM4VW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(55016002)(8676002)(478600001)(6506007)(186003)(53546011)(7696005)(5660300002)(66946007)(66446008)(66476007)(9686003)(66556008)(8936002)(64756008)(76116006)(86362001)(45080400002)(316002)(4326008)(33656002)(71200400001)(2906002)(83380400001)(52536014)(26005)(110136005)(966005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?xKDY+gSGPm4Jj69VlrLxqunYyu6nv+v35fAYke/C3/dlU8SJMURQoE7ohXTS?=
 =?us-ascii?Q?Ejp9TO0PtqIyftyvz1yEruVk5toGkrs33ZAwd8ekzZuiYwBsB2OpymcNlJN+?=
 =?us-ascii?Q?c16kH1wdIgtsWXFcxa9SRHSKTzmggH1HAR6zMjL02lYwverQ4uJXyjV53bKz?=
 =?us-ascii?Q?3/q5ipwnQWihVeUZJaavq4d6lgE4NBLMkylwAnAqbDEFwb07oh40Ro6ZuK+E?=
 =?us-ascii?Q?YAcAFv0a2g98sts/D6FG8p+UbXx+vj1n3HnMBNFE8phn76+kaGKvw+i/xvnh?=
 =?us-ascii?Q?IbU3oLDw3Ti6oC6vIsB4H1S+oC87X5KihIA5LFhELBOODgmE4h3EqBjqDgZt?=
 =?us-ascii?Q?YMIjsm7UOkbeJ1c/LtiMaOCXRF7N9SQ7RKIijj+1EEhwTVuK3NvzpZ+Q5ZrW?=
 =?us-ascii?Q?gCsdtaNetCCm48lRskXTfmpMzMWn0h5G1C4Gp28G7L0R4gAqDqfrFXM0GJop?=
 =?us-ascii?Q?NwClNVOGMtgIiCaok8yvix13yBNWg1OWApvWQ8uvNpvbQ1fq3sflZzbHNe1O?=
 =?us-ascii?Q?aYrNkPT4NH5bFJP/NLAuiqN9hU0IZqII8h1YbhF7ioZ73Dryg3mS2iGUYNDW?=
 =?us-ascii?Q?4esXESSsbMtH3NgNx5pfl3f8XPp4TKwyTVFxIC/BQKUQc4kt6D61EUjMfzYf?=
 =?us-ascii?Q?yoF8s1/EvDQSRNilf9nRjQrbcXXGC3qTB/FqlOFTM7tfv8/yZQflkIFlCxdR?=
 =?us-ascii?Q?0M2HiiSxNE/3g384UC88qE/4zW2qHk22XZFL0+VJiQSPmgHt4ayIHG+RyZMI?=
 =?us-ascii?Q?iZwU7Ig8S9I2l38ZFJX/B49rGk/mq3rMDDQqVJzxS9z+ujbMP9ndFiLMbCIB?=
 =?us-ascii?Q?6RamF5IHEkcUTm9tiwIGNiVwkcDYnV1SguMizscXOb1nkKE98hGyIK9Bihxl?=
 =?us-ascii?Q?WWNNHqdEoq9O7L5ZKqyZg1I7HaOWRFgO4NSNV15mEfrkr4wqZcpuo/RZ/WaR?=
 =?us-ascii?Q?HzWIxh++JBRTLDLq3saNWEU/a/uKw3ecNgE+7yOj8rW3kmVDumi79sFcuY6r?=
 =?us-ascii?Q?N2xFh+YMCWAArsu/qutYflnfe4bXQD0YtYZqiJ07mQ+a0xwclB6Y6UFkOoL/?=
 =?us-ascii?Q?KtbQQI25BfLIxbQbcQMjRJC2AXGRXIo6QbOXox+MPgAXnIqOO03WHkfCLcsN?=
 =?us-ascii?Q?k/bhNcZPrUORHUlS768mFLlQHzGbXk0KdyhbpXSJm7exTUAmbkhsKok8AejE?=
 =?us-ascii?Q?JzyljpmAt/q70TI4j0FHOHCzACgQO5n2x1+NMEPmeZXo6hhUiZCcPUKrqK08?=
 =?us-ascii?Q?jsqxqzw5S+fZwsxvmexuouBk/hgWgUGKVtLmSMpRI6Y4kX1ishLueumf7vzD?=
 =?us-ascii?Q?ZqFsac19/pHK8vfEENB3Bzpi?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df512be0-1ca6-4398-7253-08d8d93839f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2021 02:51:18.6139 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tzktTtBmxWmndNcur5oMP9bEDdWHwIEU+0EfeY9BRWkW39pdirKFXY8PpokJgukn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1260
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Acked-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Thursday, February 25, 2021 5:16 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/swsmu/vangogh: Only use RLCPowerNotify msg for disable

Per discussions with PMFW team, the driver only needs to notify the PMFW when the RLC is disabled.  The RLC FW will notify the PMFW directly when it's enabled.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index fd5539f8b53a..3f815430e67f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1647,9 +1647,9 @@ static int vangogh_system_features_control(struct smu_context *smu, bool en)
 	uint32_t feature_mask[2];
 	int ret = 0;
 
-	if (adev->pm.fw_version >= 0x43f1700)
+	if (adev->pm.fw_version >= 0x43f1700 && !en)
 		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_RlcPowerNotify,
-						      en ? RLC_STATUS_NORMAL : RLC_STATUS_OFF, NULL);
+						      RLC_STATUS_OFF, NULL);
 
 	bitmap_zero(feature->enabled, feature->feature_num);
 	bitmap_zero(feature->supported, feature->feature_num);
--
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7Cfc9e11a03e85472da68e08d8d9097a55%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637497982034673351%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=zh9Mo0RQKHsPFO1GMY9%2FVkRj%2FOoB3gWwlXE9%2FxX0u40%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
