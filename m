Return-Path: <SRS0=BBBq=HF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2E7C433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 04:44:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C85964F67
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 04:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C85964F67
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E3516E2E6;
	Wed,  3 Feb 2021 04:44:50 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC47B6E2E6
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Feb 2021 04:44:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9dlUl1qieAsrLyBWGlE8aZWhi9cT1RdlDYFo2NtqiralnIOl5qSlp+1Oin0JiweG2Oetof1W/wu2eRpdGMjFKs3MsN7dXbA8e/rJ1Tf1ayBtsrSrfr0R6YtSweHiKIxZchdOlA/3ePyVP2o1cfplha4R7bsfs3N21lwBpublO7pR4oc+dREfE+oVuV3tsSStpbBIwzNqk7tPIp9q265jpEu+lOJuG8V1hr1KwlFznUhUdXlnO0TlHOAfNRBsqGk+mCToNhy/ezFwqlFwNsMbw/RFvJf/JkOrh0VM4MGJjaH3LmOPsB4iVBnLd2k0ZnT6sSLkuPWMihtTSndMsOO2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tW9tP6M4xicnk+KOoQuFmGoG9vB2RHrDUuzBpHslr40=;
 b=TdTez3Z2QSfkcG4suIyI9vAl0SBpcPE8m7eyUjlvFVpa2KVxPyd/CgC4qkMP2hbZhWa2C6znhbOVBQQkhyaQRG275Di8B+Y5DwjMHzKck8uf/i2gkyQWfl3P/0S0WalyzklYyam2re3G2gJQ0I4jH9E3FzTVTAGdb7UPtawAo6voJMMYxWstpaadQXvkvXUSPpMjLz7sZiTSGWtRWnD9v5ujPHx7NOMYUN06voRtkE4hwy3Zbs2NxIXWcAOAv0me4tCvPAHBtsaJ7AP1TDmnrEjDNGJwj6tLEWKQcw4O2CHJ6+nmz6y58KnN1VlkZl5hQybuzNuKoaOiUAwEVgshZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tW9tP6M4xicnk+KOoQuFmGoG9vB2RHrDUuzBpHslr40=;
 b=ONGTMOs6Y3ZF6IXtehi9i2bQSxWNkepqHjr/Jy2V+2EAVrr0lN7X7jSYDI0gM15pgi/WdYKoPvT4f+b5b62hbKoOTigAP+E+LgctWDQpTysKhSZ3VvW8YfTKudHG9oEYhe9x/12qa3H5KZ2CbYJzrpNDY/q45yw8ycu3rdF7lmk=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3274.namprd12.prod.outlook.com (2603:10b6:5:182::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.23; Wed, 3 Feb 2021 04:44:46 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3805.028; Wed, 3 Feb 2021
 04:44:45 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: enable DPM_FLAG_MAY_SKIP_RESUME and
 DPM_FLAG_SMART_SUSPEND flags
Thread-Topic: [PATCH 2/2] drm/amdgpu: enable DPM_FLAG_MAY_SKIP_RESUME and
 DPM_FLAG_SMART_SUSPEND flags
Thread-Index: AQHW+Yde5kjjgJ8Mb0iW3F0xAJM3Q6pF22mQ
Date: Wed, 3 Feb 2021 04:44:45 +0000
Message-ID: <DM6PR12MB2619775A3BDE645D1B01EB38E4B49@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210202171748.1062530-1-alexander.deucher@amd.com>
 <20210202171748.1062530-2-alexander.deucher@amd.com>
In-Reply-To: <20210202171748.1062530-2-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=7cb51fa2-9c1d-40e9-a7db-97cc02b0ae23;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-03T04:44:19Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 15630df2-38d5-4cd6-95fd-08d8c7fe6e56
x-ms-traffictypediagnostic: DM6PR12MB3274:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3274B00B2B81B152444F5A0BE4B49@DM6PR12MB3274.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 98p9o/nfnetGwAXAe6qH0jcWz8FZ5lj+RZ/Fxy+ipc1D1sEZDA+sX0a/53YBAhGM5qPwSMf4TpzDEAvctg4ALvmUJ2lCo17T56P5lK0qckYp9wbtxPbIdl2eTcgl7N7BVP8nJ6NKRQnhwW4TqRI9Mv8E0IdVO294YYQ+A/9kOGpCY1JCqRjvi40KRdQA8LzlrMlLLhusYEGSyDAkIbXm5I5Vd4DNJhMowmP7MXgOvQeMBKuhZtKwr+ROc0ySdii3MW/5s+rv07cVtn2M5EfglFG81acY1729jZKScQ0o7TDjYSrae9A6CvpUt4EJAipNtz5aR1Z4xZkZ0MLLd7BRGvTSpCu2JJnkc0oo74BpymFXaNvpOKJZ1UOz9DmXA3HGoehHGjdNB27A3VVp3SzAoKSMv3xU/vUh152B2aVS6ziOPDjKurLkvAvpuRdIsuQ4laVQr4U9JvS/imj+4LLNbrmJAPXxP3KBhsUM0/yS/aHG4ImeCz6pAS8jKDxJiFq2CpIG71HGRqcPPz6zAyNq4Fd8Arahb++kGXeGdU9U03aylN/2SZChxE4CfuYS+ae+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(8676002)(2906002)(7696005)(186003)(316002)(110136005)(26005)(53546011)(83380400001)(966005)(4326008)(9686003)(6506007)(76116006)(86362001)(5660300002)(55016002)(45080400002)(66446008)(66946007)(64756008)(71200400001)(66556008)(66476007)(33656002)(478600001)(8936002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?DemcTii1sbhoap+y09d5CGbHDJuqXTzeJkVrIRMkzL+xMYSOdNY1ZBzULvbz?=
 =?us-ascii?Q?y9v2juDlVvHk8kqncA95RfckeBMfAPH8CTgc6LN6bt5qqOw2918wJmw9+Tqe?=
 =?us-ascii?Q?lTyodZQrPNojTTkC19HpQREWSwY48As+o9jfAWB2XZCcr/PEetBEEGmUW2R/?=
 =?us-ascii?Q?p72w5ONjYS4LqwW/BRg2fHXXUTIJ5DlrBInMqLt3Udw6Ks5Ct+dZKF0v6zcY?=
 =?us-ascii?Q?fQpNGkHCKp2I4T3UNILUf7ntPseQS/EynnH61RUHAcaxobOlVC2YemfPj6kO?=
 =?us-ascii?Q?Ft12HJ+p98QXdE9nMCRzpl7oMZGsbPcd+dWXTsot+Gtin9HqpbiqOBnqfMEB?=
 =?us-ascii?Q?GKOUtJZUVlLXs3/JvNlZbXMzYJT5S8tILw6wUmVpE0Py6M97uCBtsck5OISs?=
 =?us-ascii?Q?HMy9AaIq6+ssKTOK0TZ0hE49K7VGUg0t1NkVvUbc8/tX1VRAaSLGr04QUrO1?=
 =?us-ascii?Q?6bgh3CmlahgZe4W9hZpmtrAWoK3J4OuIsJUUYqDmJa9yyKCYY78G6iexP+jv?=
 =?us-ascii?Q?I5s+rhuegsBQJ0DGpJY1OYOTBXzpQiawXk6fPR7w2D6uE7PcLRQM0ezds6bs?=
 =?us-ascii?Q?clOf8Oy2+2rauNqOVvZH1vV74GpoV0Gxo7ny8YrOOW27HMZ0gLI8JObD5tn9?=
 =?us-ascii?Q?kn8gMmboa0SPzRtCQJr9bKbWamhZGrRG52uLIJXYUganwK8DPvJOUBhzFlZP?=
 =?us-ascii?Q?KDWCd8zyeL5qru6CfhXQ3Lxtfk1p2NIyBgA+0H8TY7DLg8dBspAsfgstJ0X3?=
 =?us-ascii?Q?9xhLp7G8NF4LWjBH2i5BJCnHcewt1Aa5iJ4zLQQB0M/0B0l60/lubYmbgk7r?=
 =?us-ascii?Q?Pt3uicEmaITCb7JRxaZcG7oJXqLG5CKp8Vut/cdjrmkrXmI6YUhKOAEXTnP+?=
 =?us-ascii?Q?zfeEvorPG1CyxSJyLvz4t8H5fNjKLRTXKI4On1zD6oRWa2bT0+yEule8JeSW?=
 =?us-ascii?Q?W9zTTIabEpX2ADw1MJyX+7Rj9S9WZpIE6W6LaC9WmJE+rdiQMJZHu9OAMI2B?=
 =?us-ascii?Q?wid6X2Wap9MDSXDL+TJCHOBDY9lwZOkydicrRZdP7iF+WtmoThL7ZLCSShZt?=
 =?us-ascii?Q?1qMHchqA?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15630df2-38d5-4cd6-95fd-08d8c7fe6e56
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 04:44:45.8604 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s7//BZlUAt1Rjp1iFCtrPLHfCtMtFF4U2s+lCxtPbK+axL78DyKAa4ckdsjgqihw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3274
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

[AMD Official Use Only - Internal Distribution Only]

Series is acked-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Wednesday, February 3, 2021 1:18 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: enable DPM_FLAG_MAY_SKIP_RESUME and DPM_FLAG_SMART_SUSPEND flags

Once the device has runtime suspended, we don't need to power it
back up again for system suspend.  Likewise for resume, we don't
to power up the device again on resume only to power it back off
again via runtime pm because it's still idle.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index b4780182f990..b78847fa769b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -206,6 +206,12 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 if (amdgpu_device_supports_atpx(dev) &&
     !amdgpu_is_atpx_hybrid())
 dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
+/* we want direct complete for BOCO */
+if ((amdgpu_device_supports_atpx(dev) &&
+    amdgpu_is_atpx_hybrid()) ||
+    amdgpu_device_supports_boco(dev))
+dev_pm_set_driver_flags(dev->dev, DPM_FLAG_SMART_SUSPEND |
+DPM_FLAG_MAY_SKIP_RESUME);
 pm_runtime_use_autosuspend(dev->dev);
 pm_runtime_set_autosuspend_delay(dev->dev, 5000);
 pm_runtime_allow(dev->dev);
--
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C8a6f7c5bbab84c6e71c408d8c79e7edd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637478830857036614%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=O8I5HOE3ugNlFpf8f5XI1665h2IQ4VRCj%2FO53yDXGpQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
