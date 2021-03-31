Return-Path: <SRS0=lEWV=I5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C84C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 09:01:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D93EE61996
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 09:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D93EE61996
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2E676E128;
	Wed, 31 Mar 2021 09:01:08 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770079.outbound.protection.outlook.com [40.107.77.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C6C16E128
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Mar 2021 09:01:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSuE/WZsfJ3ZW3wjZwc0/IuROeHaB8ujDFhbBWpOoQ5/tolDlmP9Lq2rY3JRtzLbISjtt0gWSMmmjMPnYnA7WR47Il2R4p1ME/kJ+PPzG+Nc4LD2sv2Ge7cTHbVbt9oo7uWT/BQi3gpDCGNrtjRj7UPpaJ37HxpvzwfH0ue1KO7kQfzjU4CxArxAk7et9yq2KS/RxmWDHkrjjCgx9lcTdd9XgWEbW/0bdZ5az4EDUTUQuXJ/aK2NnU4KW7RHKPixhBTZCeCZDeYEcc5jLb6oytXjfW1L3QDW9PZcFiU1bNtHUijPNm++LHBEo6n8Ip68L7D3ZOKKJVlPobm4SY8t1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UR5cwWNHrmjz1l5SMFoS0KXZClvop51Y147/e6yA5Y=;
 b=WPO0YACj+Jq54xS7tomplTBL3CqMeCS1V19bW2NNtVhRgrQzLCqRDJ6N6g100C67gWAkKQcGCiq9aqCV+pg4hzDospIgXB4BiKyrAS25HBIGib5U/8n2quWwZ5TTjOVQmaihZG/VWeBgS/XE/IiXm4WhCzdlbSob+VFszBZqU5u1YZqPqIwrrGS6FWFCucAt2lnfs9mT+bFvbVn80W9glqBPu/rf0JS5vDhbUGge5aPz42ONxHLCIK6Kdb0XgPG7xj5p8jutYL6dHeNmZvgywb6wo5YgEeCbKL8cCOQRv/QDA7dOmJbnbqVf559CLxd2gu7WFp8dHvJkc7Tel8dy0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UR5cwWNHrmjz1l5SMFoS0KXZClvop51Y147/e6yA5Y=;
 b=Vu2iaVZOPxk+6EsqqOwY2AFw5ZQswDy+djQHnUdnn1XvZsTmLlSWvLkGHy/7u48txkzr6k+YVydX5X9EyPvHknuDTNfLmtWOGmdeGdbp9A3P7wvqnHfKThI7T54zemWWazs3p7U+savYxOS6+dAC88Tk+vlV+dAkGGE3C21WQZY=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BYAPR12MB2599.namprd12.prod.outlook.com (2603:10b6:a03:6b::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.33; Wed, 31 Mar
 2021 09:01:05 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132%3]) with mapi id 15.20.3999.027; Wed, 31 Mar 2021
 09:01:05 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/6] drm/amdgpu: Disable fetch discovery data from vram
 for navi12 sriov
Thread-Topic: [PATCH 4/6] drm/amdgpu: Disable fetch discovery data from vram
 for navi12 sriov
Thread-Index: AQHXJR8IXBSHD58UNUm3b3+j87tUmaqdzn2A
Date: Wed, 31 Mar 2021 09:01:04 +0000
Message-ID: <BY5PR12MB4115AD67320252B43CA577CC8F7C9@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210330044147.57802-1-Emily.Deng@amd.com>
 <20210330044147.57802-4-Emily.Deng@amd.com>
In-Reply-To: <20210330044147.57802-4-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f0d50e74-3927-47a3-ba8f-9a33cf3fed04;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-31T09:00:58Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f47d5581-44ed-46bb-3c52-08d8f423842f
x-ms-traffictypediagnostic: BYAPR12MB2599:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB25991A034A7DDC2A0E7825088F7C9@BYAPR12MB2599.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h8PuajMpME5eWs6KL+G48DunNLdZprrc+YjtzTi/dO2h9UhHYLZ5gLVE5kL2vNT450H6YbgJYrghmjfycGh/GLETn2Rz8t96B0QhYUAaU+92VaObvc4xuDq78J6NkOS3GPMd3jrTSEBGgOn+AcoJxiX0zvlafNwgj2OeB/XyfhIu3Wqxz8jY9hYYzRMEDanaUeU9eJV00c+cU/XMZ+7bKEp0CdCquWVcP1GbFYWwKXqueCcZ9QjXLmgyNQwm1gTj6mGI13AE5P35zyl/uMJZy3zflGqixyCDtDfXAbIiaa/ZEKDP39SoKp0mOs4DBLPW2aR5Hq/EMEWlr/2VlxAWUfKJCvIeMIXNCcmVO1bq9tRiPxlzfnI/edMy28WBxpKsBhyljh7uXd3snmML464YZpEJ4eOmU3HzegwFSG/1sLmbYB//pK0FnRY0QvvmNOtgZXPzvQ4uEmBU+xU3yKT6HKim6l8xUCMD4I8SJEoz+6J9sHeUVhswEurycuIFlRtnPPB6j2n0n3UDkgZwJYeP3JZwvIj0MWplRB7jbhP9jXNP0Vk0mmVgfA06CKcGIfIKdVQuTyWTTPzHlq14vmbhIt2ZnaLo+LqJZPc76rqUOLhGG95BnUYjvAI5FWUZTyryZPICVQDUbZFYXsVba3KzkQaVWk3OK61iChFquCC/vME=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(6506007)(5660300002)(316002)(33656002)(110136005)(38100700001)(86362001)(4744005)(71200400001)(8936002)(478600001)(52536014)(66946007)(7696005)(55016002)(8676002)(76116006)(26005)(186003)(66556008)(66476007)(9686003)(64756008)(66446008)(83380400001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?AYN9M1R+M82Cd+7GSQZhEfnT1aCCGCb621zbpg4oat5hi7Ag0cHGX7gs4hsW?=
 =?us-ascii?Q?2WLZSRX5LMnW0DGeRufPJ4ouq4Yr5FGbFXkw0kIbpou9Ah6tQlfKq7G/UAtm?=
 =?us-ascii?Q?M/Okfk3TPkADhPu8zirm66aFy1W5uKC9n8Yg8cy5oChUtCyvo6zeCR/M7gy1?=
 =?us-ascii?Q?ci8yv/Wdzd9VIXPx85urEDM3eppZ6I3YRzeZ3JJBP9VhfWzymje2G8txwbnR?=
 =?us-ascii?Q?evszWQqlNNYEUeAoj1KKSZFlWXLmy5SobqpQJGWDTmOWyC3k9ZXVWFqKhBWU?=
 =?us-ascii?Q?Sl6Gf+4GICCGC0qZ22QDc3ct7sRz5IXsBxMEqTSJB21D2LLccDevwBoXI2A1?=
 =?us-ascii?Q?Xau6TaNEG/wmUkTQWSb9PtFNUmUNmEBUpLNeohMOpGDS2b2ohQlMIX90zV8m?=
 =?us-ascii?Q?J/izBurn+MzrjNmF1a1JqSd2ECb3lK/TXAIO8nGo3QiOS9rrWu+jzb+rsNrs?=
 =?us-ascii?Q?D93MvmImeipmeTe13Sa2jFvFF9Dp3WHPlrT8TTaUThmDitf4xq7Q9L6pDkR8?=
 =?us-ascii?Q?MwPq9zI6GP2I5GLYtyC5fR+ogTuuvKkWzysCjSVXCIs8nTFa0ry+6oysxR91?=
 =?us-ascii?Q?HgdEOerSB6IsiQ/XS+dd0iSLEmSwu9SPXOJYXmVy8WvBl+pA1aEE6rKkYTdB?=
 =?us-ascii?Q?5wMKgqvPRUugZBM43VqKs4Ii7T+FrbqSNMFBlKZzSfrkX2IVsZYcHY27SzZN?=
 =?us-ascii?Q?ohEPvMBq5Jzgu4QABW6wfDx5QEiXBS2v4e1mmkWXDyqfiKZ63ei3qqDUwtYL?=
 =?us-ascii?Q?GzBA76xK9P+xscasLqLb+y8FjRsYKKmmz579AvsxHJY54MPAFg3pONffgc9M?=
 =?us-ascii?Q?nTscdnV83faIoweUTZTdo4rqulmwfFNxBy2DNKD5VW5BnJyrqr4XDk51yzpy?=
 =?us-ascii?Q?sFAXm2QV9pq0+nlmSkqy/jo32U8HtRIngCuZAwTkHR4l73LWTJXjxY23YfAG?=
 =?us-ascii?Q?spfl44CFnlyFEIwqLadWszroUl0nX+msA0I9PmLcd632f+XuVLtwsw26uW00?=
 =?us-ascii?Q?sFYOLcKJZ6+nXFbplucc8vk9Hld4ntMZdewGhNNzhW/krqwmndP5sNlXWiQY?=
 =?us-ascii?Q?WuHFc/380r2VktNn8Bfh3znEpDb8MPVQIZ0B1YFNiIBrMQszlnQ4UQ8yuJBt?=
 =?us-ascii?Q?T0dVGhBUu1iaCzzUgV/I3OQxyydS4WogljKana7JQq+ULj55uOAUI7M0jYZA?=
 =?us-ascii?Q?q2SmtBqw4oZTiHNLovgcAX4PM/EVjhu0omJC/xdealygEJJVOreisdsn39qL?=
 =?us-ascii?Q?MzkkaDcOEOdi6joUkjeznY1CA0NsBXDQ1slNvYd906C7C7kEGEWnNcwd2tSm?=
 =?us-ascii?Q?Ck74Zw+kdn5+kO6XKFP/zJCp?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f47d5581-44ed-46bb-3c52-08d8f423842f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 09:01:04.9714 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zv8YpW7qJPflRvn2uXOXssjbheYb6HgMm96qUUdjWceFigDjG8iPPhiReQVofRmR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2599
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Ping .....

>-----Original Message-----
>From: Emily Deng <Emily.Deng@amd.com>
>Sent: Tuesday, March 30, 2021 12:42 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: [PATCH 4/6] drm/amdgpu: Disable fetch discovery data from vram for
>navi12 sriov
>
>To fix the board disappear issue.
>
>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/nv.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c
>b/drivers/gpu/drm/amd/amdgpu/nv.c index 46d4bbabce75..48dc171bc759
>100644
>--- a/drivers/gpu/drm/amd/amdgpu/nv.c
>+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
>@@ -693,6 +693,10 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
> adev->nbio.funcs = &nbio_v2_3_funcs;
> adev->nbio.hdp_flush_reg = &nbio_v2_3_hdp_flush_reg;
> }
>+
>+if (amdgpu_sriov_vf(adev) && adev->asic_type == CHIP_NAVI12)
>+amdgpu_discovery = 0;
>+
> adev->hdp.funcs = &hdp_v5_0_funcs;
>
> if (adev->asic_type >= CHIP_SIENNA_CICHLID)
>--
>2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
