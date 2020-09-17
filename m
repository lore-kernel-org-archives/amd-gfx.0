Return-Path: <SRS0=QzDn=C2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5408C43461
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 09:39:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AB882076D
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 09:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WeumXpTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB882076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCCF36E0E7;
	Thu, 17 Sep 2020 09:39:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A60C46E0E7
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 09:39:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2fXOcOJ7tmGoGmOe2E0ppSXKI9gybyS+o9RsviqJzHLkeJ4WKCaiR/W/6RKpg8EWxJ+fayQ4lRdmYIdbO/UOLTxCnrOqn5qnYIZLwC5gkCTKOj3U1LX9bUdOFDLTon8DImGZXlN16T8z79yqOXv79tUvuw2QdQiEIwf1RZuj+hUicsSdctfOYBna1srhPNcJeblrYoawvwWT9tgIXpBcDuxbzroPU8Dyef9YnkTDtNKWLxs6PT8LvM2ZixCCWFqHg8zXXpsEJTwgv1PjlETzg8mnBDxpoR8D/c47R69rQvQxDEUa2UffsTbWWG5XX2DniK2u9XQs6BokdSVM7LJMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RN96qbbKy20RByEWX7CLphWYkETMdrRIYmImDO9xDeQ=;
 b=gVTCbwL7TbYOm6L/a8CNRYKRmWPYOCWHj/Ld0HClQA0Td/5nL9igDCxKVk05qMLiw8ooZ91RhdNvmu1e969O6CX1EDpCjdHW31BHfMW05AONZl5ky4l6zH5HxmsATLMR+y2h30aH9N1GNmtcdXgxoH1Z2kkfy6K7iYaNugDIU42J0D8i6IBdO35VYKo7wKJZPlOIFGTKxDc/Fgv4rOdRwi9LoexCsMwaitA4p2RcZrxftTqtwtJtigzHqhbMsexGX5AltFnfVnwdQT/tpx+ZAL5gJEbIfsL8SVWkLcNtzYro4LqgQvOEVbPJjIHmCz/QUylM3f8phATbX9RikALenQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RN96qbbKy20RByEWX7CLphWYkETMdrRIYmImDO9xDeQ=;
 b=WeumXpTpPW1o8JQf7iqiA95S3tBkkhLVxjiqubieJLWL/5c2ZHTQzmUmiklTyCxkbQxiOG6I5fMvi9pCzLkNGfcFPL6e7AxO7dtA5alU47fOCoDv2MPTb1RQQJi+u2BqfiUK0i10YsVy8Kjyf5d4jfy9vrYizGM6m+jtFeHvQeo=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1413.namprd12.prod.outlook.com (2603:10b6:903:39::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Thu, 17 Sep
 2020 09:39:34 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e9ab:dad0:9d7a:a0e3]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e9ab:dad0:9d7a:a0e3%3]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 09:39:34 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Chen, JingWen" <JingWen.Chen2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Skip smu_post_init in SRIOV
Thread-Topic: [PATCH] drm/amd/pm: Skip smu_post_init in SRIOV
Thread-Index: AQHWjNNrekyhdy881UiQ9Tm31S29l6lskudQ
Date: Thu, 17 Sep 2020 09:39:34 +0000
Message-ID: <CY4PR12MB12873A51234ACFE8AA324571F13E0@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20200917091654.1045366-1-Jingwen.Chen2@amd.com>
In-Reply-To: <20200917091654.1045366-1-Jingwen.Chen2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-17T09:38:24Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=c4fd9a34-5504-4a7e-9b20-0000ae41e400;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-17T09:39:31Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 67317a89-9b84-452b-b102-0000f79635e6
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9bd39091-9299-4192-fff5-08d85aed964e
x-ms-traffictypediagnostic: CY4PR12MB1413:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB14135ECD40481B8349C71092F13E0@CY4PR12MB1413.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EJoKAJuVctQX+S5owerxVfpFg7sMxRMvheKBWDmS/TAqh9vn+UPxtXIVy7oq0x6TZuxW8AAQoXecrwhN3ohNwqyGEBvDmDxdr/eg/AwYBw4w49wq2DQusyGSlFFL4i4Mz6wWjsjVpLMFKhAtyW5KRUr16HrwT07BrCZiRdVZrzu0hiAgTv+akdtFB/E78/OglkFQ1H1uRCoDK7+38QAcff4tQNXhhvJmhWZ7dAWpqmCDNvWS3Y2bmEYcRq8UMkjoB+SNmIQHZlalbNnZ3TN1xBpqZhDsmFm8rZdX6wGrOONnj6pN5FmKFUUKCZygis7J0aJ3zEg8qVD8zYc18ohJO8xYuFZu4CAbFUg52o7tevg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(66946007)(64756008)(52536014)(66476007)(7696005)(66556008)(66446008)(55016002)(966005)(5660300002)(83380400001)(76116006)(4326008)(478600001)(45080400002)(9686003)(8676002)(316002)(33656002)(186003)(2906002)(6506007)(8936002)(110136005)(86362001)(53546011)(26005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: y/Yf/kBVZvZlpy3K3C21bW+56zh/t74iQf//EvcaRblAZwt11EW6e3iSvpTwzbRPyeBybRKNTziY+4fCrIr6E0pOGknaP57k05NyJP4Lb+VW6/hXd+u8/G+HaROnZF9Tcxl4uK1WGmXim+s+ig2VGd9XVEpXk9rbT2b5TOmFVf8hnH/uUjKjv3c4L27JYHolBETzbj/whu8zdGyHZZSHf5ZEtveSmwHqMXg3mgTglnHvL+f1UgJk1qU7E862WOVdv4NvgEtbSZausg/rZ+k3jxtk6ec743dZo0NFV54H1yoWCx8Se0fOZVLkNCPDZwo4euTuU5tiMb/d6lUzHtIYIKOiW/Gw/GzRQUSeaJ9DOrNPMTfMenGu/g+yEEiEuZzySS9EmjltCMSl6maTWJhvfHWKSYLJobd5u/rIETQOZXu7ifI6//ytCLmdKOpwypL4e/B0JU+dgt46hPDm40Ao9KHSDo0AZGxhy4IG6ItnbH7Dslhurfvbw7qODNxvX2ipczdzVDD0oKe30A4S+Km2247/c7Ve4ChOZjb4KiniNwBUoBAiz8vyIE0Ln8evDpw+GAu3xxtSNfKDIXG5YjQK9xY5yWooKg1vkIrUyzg8/ICysReKxopxZPIhvcxYk7ZNKSuNi5cS2Nfz/58mzBXAjA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd39091-9299-4192-fff5-08d85aed964e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 09:39:34.6964 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wmQ1SF2IMpGqwHeI3tlsOD217PbA1v+3nb/klJzeMtu3nHv2OMn00T+qaRA88n1WYspMUsdaFDRYM0EQLjKSzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1413
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

[AMD Public Use]

You want to call it in SRIOV case or in bare-metal case?

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jingwen Chen
Sent: Thursday, September 17, 2020 5:17 PM
To: amd-gfx@lists.freedesktop.org
Cc: Chen, JingWen <JingWen.Chen2@amd.com>
Subject: [PATCH] drm/amd/pm: Skip smu_post_init in SRIOV

smu_post_init needs to enable SMU feature, while this require virtualization off. Skip it since this feature is not used in SRIOV.

v2: move the check to the early stage of smu_post_init.

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index a027c7fdad56..a950f009c794 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2631,6 +2631,9 @@ static int navi10_post_smu_init(struct smu_context *smu)
 	uint64_t feature_mask = 0;
 	int ret = 0;
 
+	if (!amdgpu_sriov_vf(adev))
+		return 0;
+
 	/* For Naiv1x, enable these features only after DAL initialization */
 	if (adev->pm.pp_feature & PP_SOCCLK_DPM_MASK)
 		feature_mask |= FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cguchun.chen%40amd.com%7C12ec63de0caa4134415008d85aea7b6a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637359310721844702&amp;sdata=9JCzyhqPIKMZV%2BBEL83HZyfwCyZjTP5iPgs7Hn4Epx8%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
