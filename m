Return-Path: <SRS0=y+Th=FL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702FDC4361B
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 14:01:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E2A723444
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 14:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E2A723444
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0CD46E58E;
	Mon,  7 Dec 2020 14:01:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B9EF6E58E
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Dec 2020 14:01:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSR5mTcRrqdwTO3nTyhDDYK/Q+MTd8AkjNmKb4dfn2/CwMd+75HhkJj5ZFsgen6rsz4Gs3GL4Kr1x9mOGv3LN7UFqNm9kHGAQwh1CWOBO9COczE/JvFIciSB16rQPJp32ujD33fVCK77Gk73SqF+D8/pgaHG8CTXuoVcRVNK0wPFJADiV8ETyG6Lpb2V413eZzn0plkIDHRR6GASmXw23muV6Cv65FXdAYRSX4HwEPL0SJD5BnaEWlgdyHT4OqCqIs9xjXQX/dXre1EChW04RoT4SG/Klk1v9n8E9gKvg55VyOf9M6xmzKJFd+usLW9WlNmg8+sjELKAeZeJrTz/pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+7oxDVHtKkYPPWoTHbO9MvtR7FiZrwIFQImvpnaQDQ=;
 b=Hp6mE26DD9WrGzS2sKJjOpcLakAVz/TEN5gkHAzy3u35rfQRYNQRm7iS3QIqgVMikRAZKc5LDGYCho+m04cOySjbhYrfqo7xpcws2D7UJPYKknr/BaAcA2r1aF3/NXy8ekJbUSx1wHjjUdRDGJ8Es+iluPvAnbBhm9MEr8Qaq18kqgrxvETXhOjFBaTA+tuMe6L7eZAVOZNaDta+ZKtmcMExWe4TY5SgW5QBEqQLdLxlmbLPvClYJlpspCPniwnIcZlFuz0aYKBF0Y5hRzveo7FB6WEO2/lf8wM/AlXTbLbFBvqvhM01nfm5RQqAf929A36chUrnQIeGt4PzTVrgoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+7oxDVHtKkYPPWoTHbO9MvtR7FiZrwIFQImvpnaQDQ=;
 b=YFeZU892vtQ4YvHRy5wi3Fggv4d2X6rU9x4R3UK6xinoX+Yt3xbZKq+j1odhwTPl6T+orK68u2bFe8L6EkHa/sfh3zFsisFfbCWYU6l6Q2hwD0VhSxgeeQcN/hZlYF4LRHRUSctqMyvUnOE9PDPttSnzcqZEpoN2Yb7FQWvFeaE=
Received: from BL0PR12MB4913.namprd12.prod.outlook.com (2603:10b6:208:1c7::20)
 by BL0PR12MB2385.namprd12.prod.outlook.com (2603:10b6:207:4d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Mon, 7 Dec
 2020 14:01:09 +0000
Received: from BL0PR12MB4913.namprd12.prod.outlook.com
 ([fe80::4112:ac5:8125:7c05]) by BL0PR12MB4913.namprd12.prod.outlook.com
 ([fe80::4112:ac5:8125:7c05%2]) with mapi id 15.20.3632.021; Mon, 7 Dec 2020
 14:01:09 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/pm: correct power limit setting for SMU V11
Thread-Topic: [PATCH 2/2] drm/amd/pm: correct power limit setting for SMU V11
Thread-Index: AQHWzHqPt4F4aG23y0m+2T/HzHGr5qnrqLUg
Date: Mon, 7 Dec 2020 14:01:09 +0000
Message-ID: <BL0PR12MB4913534AAD30DEC4F5AA66A197CE0@BL0PR12MB4913.namprd12.prod.outlook.com>
References: <20201207092232.81415-1-evan.quan@amd.com>
 <20201207092232.81415-2-evan.quan@amd.com>
In-Reply-To: <20201207092232.81415-2-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-07T13:57:27Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=8e74233f-c43f-476e-80cf-00007de2db24;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-12-07T14:01:06Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: bc4e3ca0-1112-4de9-8819-0000886135d0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.201.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b1583bf7-566d-45db-cb33-08d89ab88c4d
x-ms-traffictypediagnostic: BL0PR12MB2385:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2385215153B6BCCBB0B078CA97CE0@BL0PR12MB2385.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:655;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q71UQhgM4uDHmJuWHLxGOQ4UwZk6/NPhz5tdiiTlZ9ADxoSmsDM9jSJ6ZVPgIACe6/Zg+f6G+fX5X3Fz7NEhOXicqk3al6ZYBF+oWmBsE7v7jO5ftMTH3AIpUb0psvM82Uun9VGoP98yaM5ydRx5DvjsgF3cegPGKMYWW3bF0o0pTEfC+5q800vmLSRhlCoNuqf1glQ5Z1Q6mDheoItyfv0lYGAQUtY5ZLswUGp9bL3+RdVryxgLtG9wlIQhFa6rI+/kMNL2OlD88uvcwO3l+Yg6n8Y8HCiscODD/tIOBvWPyb6bqROQ7oMl4ySwSMzOhXItX+/cUSRpYgEiZnew/Gig2R2oKarvMb60XnNJCzY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4913.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(186003)(6506007)(4326008)(8936002)(33656002)(64756008)(66946007)(71200400001)(83380400001)(76116006)(7696005)(66556008)(55236004)(53546011)(45080400002)(26005)(55016002)(54906003)(5660300002)(9686003)(478600001)(110136005)(2906002)(316002)(86362001)(966005)(66476007)(52536014)(66446008)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?0Y6TKDaTuoGcBXKlfMqFJmK6HpYMT1RsHYl3aCrQTXUXEYmq/kUAcniiiq+F?=
 =?us-ascii?Q?jb2vbPH67/5zmXTrsYCS9jIjollk+x3MK9+h2fPF029n0OiJxIo7Q/8SaKI/?=
 =?us-ascii?Q?Cv8TVb5Gcs/gqFiIOs8y/pukv+cG64RB/Rmj0bxpp7J663TLk89uOQO0uv5G?=
 =?us-ascii?Q?e9XKVsQxhy/4MlYrnJpWjP/LuwcX0TwE1Rzg+foqU44SGo0LLS7MBluQcCt8?=
 =?us-ascii?Q?1mii4J7blPwSdwYg067Fh5QyrmSsF4XsLz5XraEfzxH9k3IOUX/W+e5SVwrz?=
 =?us-ascii?Q?zgw739baLCWPnQgVUAcBWOZnI3rG3qMRCGGoYuZQe9/AC6HdVx4LbCiPQXlp?=
 =?us-ascii?Q?nh7t6ZAvIX0kj1r27MgRyQxmUpK6a4fTW1LvqZSO3P6ALSwSKYAAr2K6f5ie?=
 =?us-ascii?Q?fbHESV4l3cqqkhYqm5i/Z2GSCBytPrCO89XxI0XwKRFK3BAyrLE1JWqId/AK?=
 =?us-ascii?Q?UAP6v+qTv5mTWvraIp2ftImOnc0Krbpl7nMarV9Sp0NuFl8xZrnNqEaiud1n?=
 =?us-ascii?Q?cIOBVheYIO/i3edfPhF4s6eIrl4NwElt+uLGzLB818N/3iNnk31ekItnjBqo?=
 =?us-ascii?Q?9SBUOGvH11vhFI5hJp1rJYcXD61RpEOpvSqg4rU0oSpHj6gCQMApOG0JBWQk?=
 =?us-ascii?Q?cKBdQ0NiFTtAfk7MXoaZdY5QgNsM6p8GOfXuOGXM17Z8iMbF4/DY/ixBAd61?=
 =?us-ascii?Q?CF4vRNZZnDCFwgO0FmVsFk0mVVEjkxxG2q6boMWaQRGJSklvUsCsv7UW8hHX?=
 =?us-ascii?Q?FZRKC7ao0fD/tKpf89zk4/DUIHGczxmVmyP68tlgUAj5cXMrth/phU8AMEGj?=
 =?us-ascii?Q?9qJtzVHOJ1mmhkKMJQCLGwhp23VEuSdoAsCSEM5S7Mbp84MEPf28kZy1IyiV?=
 =?us-ascii?Q?leEWpPXcB1WaKZdA3Dzr5y83GdG6ZzG3qXDJ/ChohWbZ9ExW9CwYqhITQ53S?=
 =?us-ascii?Q?xu6rOW3xnSnv4KU1GlzTNOAy4CWGEGsNgoRrXVmNC60=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4913.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1583bf7-566d-45db-cb33-08d89ab88c4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2020 14:01:09.0498 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x1+6raBjR0TBjwk7crywoZTvSLLBR9Q+mjqSuHhcmNlNLhj67TVDoANiIqSTXXG5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2385
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

>* BIT 24-31: ControllerId (hardcoded as PPT0)

May be reworded as 'only PPT0 is supported'. Apart from that

Series is Reviewed-by: Lijo Lazar <lijo.lazar@amd.com> 

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Quan
Sent: Monday, December 7, 2020 2:53 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: correct power limit setting for SMU V11

[CAUTION: External Email]

Correct the power limit setting for SMU V11 asics.

Change-Id: Idedc590c35934397bd77b7ac825b063cd319dbbf
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 23 ++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 624065d3c079..3288760a5431 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -929,9 +929,13 @@ int smu_v11_0_get_current_power_limit(struct smu_context *smu,
        if (power_src < 0)
                return -EINVAL;

+       /*
+        * BIT 24-31: ControllerId (hardcoded as PPT0)
+        * BIT 16-23: PowerSource
+        */
        ret = smu_cmn_send_smc_msg_with_param(smu,
                                          SMU_MSG_GetPptLimit,
-                                         power_src << 16,
+                                         (0 << 24) | (power_src << 16),
                                          power_limit);
        if (ret)
                dev_err(smu->adev->dev, "[%s] get PPT limit failed!", __func__); @@ -941,6 +945,7 @@ int smu_v11_0_get_current_power_limit(struct smu_context *smu,

 int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n)  {
+       int power_src;
        int ret = 0;

        if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT)) { @@ -948,6 +953,22 @@ int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n)
                return -EOPNOTSUPP;
        }

+       power_src = smu_cmn_to_asic_specific_index(smu,
+                                       CMN2ASIC_MAPPING_PWR,
+                                       smu->adev->pm.ac_power ?
+                                       SMU_POWER_SOURCE_AC :
+                                       SMU_POWER_SOURCE_DC);
+       if (power_src < 0)
+               return -EINVAL;
+
+       /*
+        * BIT 24-31: ControllerId (hardcoded as PPT0)
+        * BIT 16-23: PowerSource
+        * BIT 0-15: PowerLimit
+        */
+       n &= 0xFFFF;
+       n |= 0 << 24;
+       n |= (power_src) << 16;
        ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetPptLimit, n, NULL);
        if (ret) {
                dev_err(smu->adev->dev, "[%s] Set power limit Failed!\n", __func__);
--
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C8e117d60de0c4c12bb9b08d89a91b045%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637429297804635030%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Hymngc63wUytPWZCrmmrKl%2FCdqF067sTlQCbfBNrndA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
