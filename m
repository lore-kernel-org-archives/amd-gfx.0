Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC459C433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 09:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B06164E4E
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 09:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B06164E4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B3CD6E500;
	Mon,  1 Feb 2021 09:11:06 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BC1F6E500
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 09:11:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gf5VWUIEiy0eNajL5V+AmOh0Rnd9eMUz38XzmfVRl41RKWbraukqvnKgx5XKG1ZKGZHuWbR2Hzs+RFp2UY3klz4Hx8Zmn4hFvdEBPalxZhvCP7LqKwsoSvXzhUgd/Y1BQS94Z0NZMfQNvinL8Py03AV42hSCeoZ444F4wexrU/wAJUXEkq6n/Am5Pn9spiHs3UxrGySOJgeC9T07WWiUpIi3CkL+AP+i6WVFgiI2tM3H6ACFiwynACB9E3kvw0F/FzglhLkQ6p6mS6Wk4Gr77iG3kQW5KFach9bBebkQCDq7zLnFATyNnePKXLGGp/waqruKiwkWG/MA+wD/2T5o7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9BYv1330mS8KFZeK6mUJ4YITTIczKG8jcaB/cypzI4=;
 b=btMm3W85HuzV4X8N5xALwO9gCVsA0RHEynovM4v1zkRYkUahLWa1Wtvrz7lNfXiZGBRbYL8x4iHEmVPduGKxt1wkDuxNycTYjNl+UhlYoCMBoYfUUInbVYZP55ATG4S8ej+nXrzGeKFjSx3YDzzXgab4Mxz70+NGb1seDtYU8J/gv/du4YBoOC18yVPrnBrhRNGU1JSi2HJqKwmaGuz0kVZYjpmnZ6xvsr/UWCUGm+wR4+tx1HhAnZXPTuPWUPyMcbhjoOboho7UUOB3mAPxdIEIaQ46PyD2XptQpsxGHWa+8YQ1eeoeI2ANDEW6dHEu4vj/ZKT2FeGjveyN3sxsZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9BYv1330mS8KFZeK6mUJ4YITTIczKG8jcaB/cypzI4=;
 b=URVvn+Rzf6qLIumKEH9GAWkcUDe8gBIR5jfdCBQZlMK4nA4Bn2pc7jM7vlgfav7bM3F0yVbY0w8XGS701iFXvEL9nv/D+ak7rZ7Dmo7ILpZL6u+8ZUAB/8BrawVwSJKzKyLCC52kN8jHmXv0ZFIyDmxlZ934X5k95N4jVdVEqYg=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2359.namprd12.prod.outlook.com (2603:10b6:4:b4::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.19; Mon, 1 Feb 2021 09:11:03 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3805.024; Mon, 1 Feb 2021
 09:11:03 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Du, Xiaojian" <Xiaojian.Du@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: fill in the data member of v2 gpu metrics
 table for vangogh
Thread-Topic: [PATCH] drm/amd/pm: fill in the data member of v2 gpu metrics
 table for vangogh
Thread-Index: AQHW+HUFdvuUCsZUT0y8qqqq8kgHVqpDA2Lg
Date: Mon, 1 Feb 2021 09:11:03 +0000
Message-ID: <DM6PR12MB26194A2E59B082307D489744E4B69@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210201083340.28680-1-Xiaojian.Du@amd.com>
In-Reply-To: <20210201083340.28680-1-Xiaojian.Du@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=986506c9-445d-4c0d-ad74-e36e2b9146ba;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-01T09:10:56Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b3ac9bda-8e99-40e6-8108-08d8c6914cc1
x-ms-traffictypediagnostic: DM5PR12MB2359:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB23591278B5DFDD38DAD31DFFE4B69@DM5PR12MB2359.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JFga/HH4He8kqGDxZmxc5V4qILcmiyh6dHEJRi0yaH7AZoKqEsrr6g1ipkEM4Z1ltottrbzhgWmhYIDCM2ZyPqYOi1zDJMeOcm50i9ZNShVQ0LlQQ4GB/vyeZK9wh6eXtbega6K+S10ZlGFz5aUM295GvFKE1cRTjSJkGwyqmHW9+mgp4MNDF+aW+5ODe0B+WWGbhWWUPjfVdTKCjZs0L5zVJQIXHXw7GzxaJUEKmC493XdxeNQVjVlv8C6twUycQVZ/CPBjsRTOmAmDE/Thy1uQOxFZNy/Ic+Tsl81s/0wu68vF99s8eAblGrrH9mtq35TkiTA1CJgRes/6ZAcrr9XtKjJhNp+XLG0W9UrT1v+ghWyJEmed+vSnQz3syCuB56J2DL7lrIOdpep+VSRKI0DmRLJ/7+rtkH4XBb9WhqkuM6myTPA//sG28GxcKZfuRjOl9PJr2lVvQFDy4LAVLQNcb35UA9AjCKZPJIK5HRHJB6vlQNYEta1tQpgwkW099LN/Wv0sL5ZzpSewJrJS4g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(86362001)(2906002)(52536014)(5660300002)(8936002)(66476007)(66556008)(26005)(66446008)(64756008)(186003)(33656002)(66946007)(4326008)(6506007)(53546011)(76116006)(110136005)(7696005)(478600001)(83380400001)(55016002)(71200400001)(316002)(54906003)(9686003)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?WVTkFcb0ylag8kLjnH8ap9tHgahQTTyJZXSblj7476CrulNqseShC5O+WIDL?=
 =?us-ascii?Q?AO+Cst2l/3wiNFie8Fnh9lQqchT5OJ6PSlR/Mund4+CqaJE2XRRYa9IMZB9h?=
 =?us-ascii?Q?98pl1msyEPabwjbVRRwjn45Q4B7iZtrYdzmbQRp4JHVYCBbf/alxIsaaxfnk?=
 =?us-ascii?Q?TRPbVfGtc84CiuzWFio55pIxzQPXcv8uNoEi5l/oKc0TMeNdPhuluxugotn8?=
 =?us-ascii?Q?9OTzbggzP6Ku9FDhYOGkPvpz0t6fic2JzVFdBa6AWxmvrtX7ZuDm44BB4lMz?=
 =?us-ascii?Q?WPfMl0yztDRL+/wG3K539MU2+fFPREb9secAR1U+4bxUrn8THwCHpKLj//9O?=
 =?us-ascii?Q?eoQ45MlY4h6pWdX6c/UVeTl8vqz20HeXPsXTVYhehmW8vzUWahbkAHdSJHR1?=
 =?us-ascii?Q?RiDeF/I60srVIUOzHypg6xBkMkQbdiRLm8Eei30eJrR7dtH4j+VZxB64kRz4?=
 =?us-ascii?Q?Ktqtp3OcZnZHsUoDu/o9lz4cxvkcyu97lIq3D6UOkCecNfBt521BiL1epWmy?=
 =?us-ascii?Q?5YAg5rRZa386ZexpeyHFcj08ML67vumpd0j/qhyBZCKxyTCSTPi1ahEkua9o?=
 =?us-ascii?Q?Zb/MDmdxXSRHPLThCxssN93mBvKgm76UyyJPxG50h4Nx1yqjMzvA9q0k58ox?=
 =?us-ascii?Q?HxzZPjvWa//LLmP+hv8NaZDPP5cSshSgxRk79rLP8ibOejU0p1hMsgQKUI0y?=
 =?us-ascii?Q?6393VD8U5Yie/alLfEaoG3uaG9S9Sren0JQJtu62gpEkkbvJjBwYHMGD//bQ?=
 =?us-ascii?Q?xFOD/QYzM0m22WPlw+vE/ka+mUc9dTtr8CyCPAn+lDPXRjnRhXytZg5N+KyC?=
 =?us-ascii?Q?kytlACullaxglCAGTMqQOX091OU/QM+wjSaiwmtFeh9kfBTLpvAR+1cbd3K5?=
 =?us-ascii?Q?Y9EWY0RUmHsJUtKlL/yIYVMRo3j/DcFWlXALwfi3v+lZ6/6RyJwydPL6l6DI?=
 =?us-ascii?Q?6dGbhBlYDXGGibl1hu+Irtbc8J89D2caK2mW25Islwl7NnfqrAJnLzYXo6X+?=
 =?us-ascii?Q?7bl8OTJdFO0o/RLBQkPtBzwE2pilKe7PvlYcPefXS/ZROw4aurb8qvD1WaZS?=
 =?us-ascii?Q?6e4Gid2M?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ac9bda-8e99-40e6-8108-08d8c6914cc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2021 09:11:03.2263 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6HqBokupaW9k6l+ddQas5M9eKhCLhtxt8yG7ch7DZw2KBh9jMT1oDwnlgsYSiHMd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2359
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: Du, Xiaojian <Xiaojian.Du@amd.com>
Sent: Monday, February 1, 2021 4:34 PM
To: amd-gfx@lists.freedesktop.org
Cc: Huang, Ray <Ray.Huang@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>
Subject: [PATCH] drm/amd/pm: fill in the data member of v2 gpu metrics table for vangogh

This patch is to fill in the data member of v2 gpu metrics table for vangogh.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 6d3c556dbe6b..4726cac8d824 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1422,14 +1422,17 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
 gpu_metrics->average_socket_power = metrics.CurrentSocketPower;
 gpu_metrics->average_cpu_power = metrics.Power[0];
 gpu_metrics->average_soc_power = metrics.Power[1];
+gpu_metrics->average_gfx_power = metrics.Power[2];
 memcpy(&gpu_metrics->average_core_power[0],
 &metrics.CorePower[0],
 sizeof(uint16_t) * 8);

 gpu_metrics->average_gfxclk_frequency = metrics.GfxclkFrequency;
 gpu_metrics->average_socclk_frequency = metrics.SocclkFrequency;
+gpu_metrics->average_uclk_frequency = metrics.MemclkFrequency;
 gpu_metrics->average_fclk_frequency = metrics.MemclkFrequency;
 gpu_metrics->average_vclk_frequency = metrics.VclkFrequency;
+gpu_metrics->average_dclk_frequency = metrics.DclkFrequency;

 memcpy(&gpu_metrics->current_coreclk[0],
 &metrics.CoreFrequency[0],
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
