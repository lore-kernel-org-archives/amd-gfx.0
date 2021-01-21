Return-Path: <SRS0=VJnr=GY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6684DC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jan 2021 03:13:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F414723888
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jan 2021 03:13:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F414723888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5671E6E8C2;
	Thu, 21 Jan 2021 03:13:04 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700040.outbound.protection.outlook.com [40.107.70.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD7696E8C2
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jan 2021 03:13:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBL7ONLy58bO5W2O3P8Ay/DX5vzdMdDi2yHq9KNfIFIMLZA/T3G4vMJ6kJlt/FeMOwnUc1BVHXoZSQbNG67ZdWCXI1tqzA02LxoMqcQY4lheVgqXdWicKmMXaid07w5Db55tlH/d8j7WqBgAN5LVBe69rXXSNRw9dj8Zu/tkAIwX0VnshR7kgHfjnmoqM2n0QHhqcD4WQgj6CYyuq6kys2OEm9cG2dtu5xI/ek/Tvb/DvENpXQmgLNwUdNbTVCKb6FGLGfJhCOqdPsMOI5zEZUhWw8lKEts01TlfPAhuU3vUIjZUxZRge66lR9rg129ulGaOIYA1mBzrONMhQqTJXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuhfgbN1nsO0tbEgwrCJ8A4nH6yvhj3QJRPl1C26kvI=;
 b=Fgxk6KRacKW4keya9eg07lvRrUCgM8ZtkJOrWmMt2ZVhasoqqYItzs0rJf7N7TyKdrchzgIYbSkcbdT6f0dzlRs0ASDKsk2KhaCvlQ6RCdcDW+L4W2Maiw8S09PJBCuY4baqoiMIi448se5JRv/9weVUYc1UrmlbonnFcmTLKos1rfSO7no9AxgvoSvW+VPuYUkm0vb4ooIYwHXdeB1dhV66q8DiKLwRMMfD6uDvxOAfWvpAp+mRXvEtg+M+8rnaF2pdcX5138m/OmzqMSYrhg+/CJAfIgHAwKxrBYR+PhCjOAz1X3qrI3aB46RHSXbN4FTHPizwb2FTgmVRedyvWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuhfgbN1nsO0tbEgwrCJ8A4nH6yvhj3QJRPl1C26kvI=;
 b=jmPyLtcE7DO9WEbWoinLglr0MIEyyKE6FJwXX13KCy0XlxPBXzyG3UFxmuV1nKF5lsBkpO9HBUiYhByZ9KupLRZ8e+VKcCH8rIpM/ZpKZe9QygcxzElH9GtteFZ69tF5/R6Nfqgk9sMfDdxbgRcc3xlfAKoH1p7J6Nd9gBKJzrg=
Received: from MWHPR12MB1359.namprd12.prod.outlook.com (2603:10b6:300:11::20)
 by MWHPR12MB1870.namprd12.prod.outlook.com (2603:10b6:300:10a::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Thu, 21 Jan
 2021 03:12:59 +0000
Received: from MWHPR12MB1359.namprd12.prod.outlook.com
 ([fe80::54d5:531:65e1:8fd0]) by MWHPR12MB1359.namprd12.prod.outlook.com
 ([fe80::54d5:531:65e1:8fd0%7]) with mapi id 15.20.3784.012; Thu, 21 Jan 2021
 03:12:59 +0000
From: "Chen, JingWen" <JingWen.Chen2@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Monk" <Monk.Liu@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: add error handling to
 amdgpu_virt_read_pf2vf_data
Thread-Topic: [PATCH] drm/amd/amdgpu: add error handling to
 amdgpu_virt_read_pf2vf_data
Thread-Index: AQHW7kJvKJSOrCTgb0CDD6lxaXB6kKoxaXdA
Date: Thu, 21 Jan 2021 03:12:59 +0000
Message-ID: <MWHPR12MB1359E8FE1E6334C9B0F5A497B7A19@MWHPR12MB1359.namprd12.prod.outlook.com>
References: <20210119090642.3311634-1-Jingwen.Chen2@amd.com>
In-Reply-To: <20210119090642.3311634-1-Jingwen.Chen2@amd.com>
Accept-Language: en-150, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_Enabled=true;
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_SetDate=2021-01-21T03:12:04Z; 
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_Method=Privileged;
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_Name=Internal Use Only -
 Restricted;
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_ActionId=14be5a6d-e73b-4a79-9061-0000c71ba901;
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2021-01-21T03:11:16Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 46fefa86-019a-4a6d-974d-000035edff53
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_enabled: true
msip_label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_setdate: 2021-01-21T03:12:57Z
msip_label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_method: Privileged
msip_label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_name: Internal Use Only -
 Restricted
msip_label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_actionid: 67caa197-93cf-4d59-9f12-00002071d6e6
msip_label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_contentbits: 0
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8931af3d-2ce6-4183-7e65-08d8bdba74e8
x-ms-traffictypediagnostic: MWHPR12MB1870:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1870232B3A70ECC692833E12B7A10@MWHPR12MB1870.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D2cB+uaVZKCF5RyfVOMwszv4wlnCOPp4pohlx6EwTuZ8avrIUYR2qLNiQ30cpeJHU5BfBr7GTKvGy2Dl/OKv6Yf1z1EMhzo4MrNk+r2qcKwz49+nMZDV9rmpKIbe5jS34WgblxjxOzZDqPoLTgtH89Zg7qXcaDkzENg6/oZ2b/YNFDz4OR6W7bdH1TRiTxspNbzOdEPwfMvR0mHplD/9GRPbtymyVvcwy4o5Jbo2XY+qabLhteejj0JPvmg6XrnwITohLRD0fZrGqIId1CRCAlY+S9cFRggBZC48jqrdYVRritO1L3xsIqp3C9sol2n0xJ+i+mxY+haY3dJH2y/mLhgbb55a6xYaJR2Y6XxjyWm77NNnuOWK4B4J5CF1XmSkxuQ0LFoQHIxIlcs3rVF/wg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1359.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(71200400001)(33656002)(53546011)(66556008)(83380400001)(6506007)(5660300002)(52536014)(66446008)(7696005)(76116006)(66946007)(64756008)(316002)(26005)(186003)(2906002)(478600001)(8936002)(6636002)(110136005)(66476007)(8676002)(55016002)(86362001)(9686003)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?cTs/65Yq9IM9F4cLOk7ITZzCEn5dZweAOaNNSzeQwLk8yZkdyC4WIYSjAUuv?=
 =?us-ascii?Q?Wfy+faMzinsfG2PUJ/7xw0Stj3wfKZpNlLGMjJ80NrFxi06Dmw4A3631IjJ/?=
 =?us-ascii?Q?/LEtRdh0VRFRSEK2F85ZbL75I7ISTL4ubVvegV0wIx12vU5i1SBABNY8eXcm?=
 =?us-ascii?Q?/3N1OAhja2T9Rlt2JSxF4afP/YfIrh4P3t4u2qIwEB6vd1lk782HNHSoHRlU?=
 =?us-ascii?Q?OlPg4aknqu7ruCKgu1CTAOM2NimwbePCnQxdTdOo6nGd0WkH4erL+nGUY/kb?=
 =?us-ascii?Q?2+g0KBGz5Y/MJuBaGMu2nbdmCq3UqpSW5vWyej8sJud9iU6YnvGipiSSJJv9?=
 =?us-ascii?Q?nZVhgHbLhs3Glfdn75zUstDaU3MmTRfWsu+RBdVYydAboJJ7ON48rkN5rGUX?=
 =?us-ascii?Q?c4Yq03JQP5uPL1uLrIr0m6Q/tPYvdssrXvIyd8NpADNAB1KGRuTGck6y7iYd?=
 =?us-ascii?Q?okxGEPji10ZBXvjHTP0HQOlplTc01EBgtI+8KA71OVIkq+4xmN4GPh+HSWfF?=
 =?us-ascii?Q?jAIoBFu99DaQe+9UpR7+jM3MHXftMe/XtugGLwPL18BJnWBMkiXcPS5yaU7d?=
 =?us-ascii?Q?sNi57o8WWXQSAt4xNNY9NNeF4j2XlRiU/PER+gTmGhGEtAs5gokFm0DqKiK9?=
 =?us-ascii?Q?ZTPrWP+nXjrc2LXadNvmEZ8JYkkhAny86bH25eaa4B01sDJ7cDOrYm14oLYp?=
 =?us-ascii?Q?yhvfgoH27ZUYD/6cIF1rc4lFJv0SU7KbZqUKzSx7g00ZAEV7hP5mDHGLbvKw?=
 =?us-ascii?Q?TPpAbo+KJKAk3tLl+3m61aqaKLhIqRxiyGatdn7pcU6g07xJKeoitiBda7AF?=
 =?us-ascii?Q?g5UAW1J/IR00K1TtOA6X1MmjUVWHM2GEiM4aPshxYOwYYlHSsvU1U+ocmjoT?=
 =?us-ascii?Q?Yqm1oN47DuWJIiPwdcVPLyAvnRgZX4UCSqJjVQl1EwiyQ8N5Cjk/fbhlViqZ?=
 =?us-ascii?Q?2aARmea1uYLjN56JM2LzmaU99nXPJ4M7iHB6N6lwyl2/wcDBlcnMAw8fhfyN?=
 =?us-ascii?Q?SdKbgsmXnC9YYR9/WGfr5k5bn6okvnWW+XaRJlWZ7GmSJa/wbKU6sxHOLzcH?=
 =?us-ascii?Q?qbLhOVki?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1359.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8931af3d-2ce6-4183-7e65-08d8bdba74e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2021 03:12:59.5116 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dRzjC96Qy4NiOd3ndIgbyhN9cW4KzeasUEwFJ7PFAe4uZu1St3EDlIPLez8/sKkI4q973D9RGlOc+H0lpQatQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1870
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
Cc: "Chen, JingWen" <JingWen.Chen2@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Approved for External Use]

Ping

Best Regards,
JingWen Chen

-----Original Message-----
From: Jingwen Chen <Jingwen.Chen2@amd.com> 
Sent: Tuesday, January 19, 2021 5:07 PM
To: amd-gfx@lists.freedesktop.org
Cc: Chen, JingWen <JingWen.Chen2@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>
Subject: [PATCH] drm/amd/amdgpu: add error handling to amdgpu_virt_read_pf2vf_data

[Why]
when vram lost happened in guest, try to write vram can lead to kernel stuck.

[How]
When the readback data is invalid, don't do write work, directly reschedule a new work.

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index c649944e49da..3dd7eec52344 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -558,10 +558,14 @@ static int amdgpu_virt_write_vf2pf_data(struct amdgpu_device *adev)  static void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)  {
 	struct amdgpu_device *adev = container_of(work, struct amdgpu_device, virt.vf2pf_work.work);
+	int ret;
 
-	amdgpu_virt_read_pf2vf_data(adev);
+	ret = amdgpu_virt_read_pf2vf_data(adev);
+	if (ret)
+		goto out;
 	amdgpu_virt_write_vf2pf_data(adev);
 
+out:
 	schedule_delayed_work(&(adev->virt.vf2pf_work), adev->virt.vf2pf_update_interval_ms);
 }
 
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
