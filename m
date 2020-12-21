Return-Path: <SRS0=mahE=FZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F76C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Dec 2020 09:22:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ED1C22CA1
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Dec 2020 09:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED1C22CA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E94A16E47B;
	Mon, 21 Dec 2020 09:22:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29B226E47B
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Dec 2020 09:22:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvgAK/XOT6n7Jqj6XKXdlXnun2v3no0MXaouOE5kbJohBumA2BPdwTERLxbCbrXyV+ktuho8moAh0iORr5dk3m7gl3z7tYx/kBHUyOhrxNSU85H0q78X1sLPDJCV/G/BuxTm5//mCZwinsuiSryHu0mRnhAO8auDbc8buCHYkQL9YcpdrPSbPCz6qcHW1mWZBiGTKNMazy1KhdIekpYJ1XzHemuqyZlh0+gX6qRgRqM4422RENXN0fxKc4yzwpE97T4JjQuMdvkj5cINFsiKeQsWluFJ7FvObbCxjl2StdOFWYf3w+HTz0YemXlhQ+Rxau3zzGhu4oR9l0aqNUegUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8Htkk0yaOT/kJ7F7IJC0c/8p3DkVZUnaHUCVm5iCkM=;
 b=BcNjqwucllMlSF81F/Ss7BL6HVVgFtNNjJgP+MHSXgzOaLY+bIZtofLItOAmKm6rAJ5CpCwqc8MbVM0+UXu4239DkydCydlSyyYvjbKyMhBwy/1HaB1AK38qZNxdkGu2HsBe5GJxddqvegGRxyvr8rA6BRmd6WQlpcfSvbD83qevsQizAr5rINjL/926ZV9pJ2FJSKvmawFpeMWwpC0A1BeKCCsEzTIxwaAhtEH1XVpCX1QX7cwcnNp07hWbUQoFm9Cmj1cb+h7sl+9pj8n8AJwXZFEn1ibxUrXdJlxJXvOybRMZDXgOBRxXdci2ZfE+vmr5XpxfiOF3BUrop1ojgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8Htkk0yaOT/kJ7F7IJC0c/8p3DkVZUnaHUCVm5iCkM=;
 b=aRfa2C3kEWTmiuc9KOT15Ym1hKNWjPvXUaodq9jWqqTdDTt+rlgBm14GluIyhy21lCdiVQmn3O/QmXM7Fh/U0P1D/wng26W1ii9hAM/4sWDBj/uB9Sk4Kl1x6UIBLuag9++iz//FwIFvARlHgYdjUBY2OCzqkBbgGWTO1UpMxXc=
Received: from BL0PR12MB4913.namprd12.prod.outlook.com (2603:10b6:208:1c7::20)
 by MN2PR12MB4206.namprd12.prod.outlook.com (2603:10b6:208:1d5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.33; Mon, 21 Dec
 2020 09:22:09 +0000
Received: from BL0PR12MB4913.namprd12.prod.outlook.com
 ([fe80::4112:ac5:8125:7c05]) by BL0PR12MB4913.namprd12.prod.outlook.com
 ([fe80::4112:ac5:8125:7c05%2]) with mapi id 15.20.3676.033; Mon, 21 Dec 2020
 09:22:08 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: bump Sienna Cichlid smu_driver_if version to
 match latest pmfw
Thread-Topic: [PATCH] drm/amd/pm: bump Sienna Cichlid smu_driver_if version to
 match latest pmfw
Thread-Index: AQHW1PiC2hC5ZqKx+UCryUe/Olbjc6oBR/0AgAADQXA=
Date: Mon, 21 Dec 2020 09:22:08 +0000
Message-ID: <BL0PR12MB4913140A6A0F6AEE12B808CB97C00@BL0PR12MB4913.namprd12.prod.outlook.com>
References: <20201218044411.109708-1-evan.quan@amd.com>
 <DM6PR12MB2619401D9555CBE9933D9816E4C00@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619401D9555CBE9933D9816E4C00@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-21T09:21:56Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=ab25dec6-eb2d-4851-8218-00009b577675;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-12-21T09:22:06Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 32d4e115-c4f0-4f42-9416-0000268d266b
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.192.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b3fe4665-b0a3-489b-e11f-08d8a591e41e
x-ms-traffictypediagnostic: MN2PR12MB4206:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB420656EB090088BF8912611F97C00@MN2PR12MB4206.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:538;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xOrScTcEupnyOIeGavOICLJJniGaVxKUZ+R2ympN09uEnArais91a1rUv3+i6jcA1MdgRqsiS7Bn43M2IkDAveL4oWEqke+3WFRJHu7ljITsPwdNv2KMX+xXhoTL1KFjP+eJeZZ3GkLHFS8H0Qjkeb1doSsF4PReBoFXIGR6GQSBQlXSiH1VdB8zbGXQGXJVG6ceo33HOevwLcSuzav+8qPR/WErpfjeHl21jt8WaLyDbMzJietP6QwHmiin/fPHzJKdRq7P1f4qQNBFe+pbRdAKlGctjScml/IKzdRYPL0b0RucfAteKpVQh8TzvlGKjx0aWZ3YHg+FBW+Kq/QlSQ2hwqKisFd0aO0gB6iDSWvvcS3uqOxcVkenzZDD2GKIkDbBX22XXsbupd/201iwbuZDw8QhVOLBLig5J9AxhiE2PGRJkme8Tu//6/nhlXOpTbtiw11//3S9OFwN0AY5mQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4913.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(66946007)(45080400002)(478600001)(9686003)(316002)(55016002)(71200400001)(4326008)(26005)(6506007)(8676002)(55236004)(33656002)(8936002)(52536014)(66556008)(2906002)(66446008)(83380400001)(66476007)(7696005)(110136005)(64756008)(86362001)(76116006)(5660300002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?X/DAcu4xHe6Vmsc1s5FQXoQlHVhu3xWoCk8tMU0Ucl9eAHZbgwnxrLX0riAg?=
 =?us-ascii?Q?HPZke0eB1uxgaA5z9FXETjUk7uNVWk+H095T9xBkGQVMI6Xrj9K4786ewpWh?=
 =?us-ascii?Q?9eyGPff1/m89oiDYaUw1/kI6TbNHElIOYDYE/vMxX+01vgxMPNPWXScNGXGU?=
 =?us-ascii?Q?5j5QrIuqK4oxvZkAGSGhLJtFCNPAcsuKIhkdJH3ty35TqX2JTo6rChnXjjsG?=
 =?us-ascii?Q?ZV8ot/ClZ9se0PhZOoJxnTjlOXPMPG5t0Sama3GYgCb+4yWP3tvM5onchl3u?=
 =?us-ascii?Q?xDMnhEI/LX2JGTr4sj49nFdKQ0BwGhsBz1l5VOcxmqaeMnauCpsO3Nj0Uf4h?=
 =?us-ascii?Q?XfH1qdYQUHTjgUeKeB6HppJ5rTuxmMZjQFbIx/UsLW1chtXEmio99JrLdxqh?=
 =?us-ascii?Q?Q8s1qp5R4V3rqYK7BXNwsVA2DlZvqZnx9XshUE5OrGLceAPJLQSN3HACe2Rz?=
 =?us-ascii?Q?Nt4YFFkn7Mndr4MwrwKWFjRAGn+aBD5/tAfEygrZgFSJqKx4sX+pNmLwhKrO?=
 =?us-ascii?Q?cWWhObACW1XI1xEDz13fQ/URKwlHjNVI/ola9A6Ay1GpRGC9ZnAZ2kT4sBuf?=
 =?us-ascii?Q?JKICjaWDg08jlAVklmN0PB8CI9p/p+ots375/dJSNh5/M3lXUprYxFmryxJ8?=
 =?us-ascii?Q?7brC8quXKLeqbPUXxvF/Qg1O0B2ArQWKTnX9sQj/cL9jEBE+9e2qf4l/qUl5?=
 =?us-ascii?Q?c4tRtm2dP7lR0OQHE/DzUmStbOyqCXOi8F/67FfvloFFTE2c67yDhlBoLr98?=
 =?us-ascii?Q?XAbmMQff9JkRCzNhEnXaUSaDZ0tdt+l115RRbDwlkkT5R5VXQQwoTGfeR7Jz?=
 =?us-ascii?Q?aw9esycMgiB3qpFp6NaDjgpQReIfgBbDwrvAoLY1WCCso2YeLR+jEl6vQocw?=
 =?us-ascii?Q?/QhyL5NI0GhDldWVhj8ZqHPHVHSNENTrkKDd3P+rUeJSIZ4JwFL37B7p1SP/?=
 =?us-ascii?Q?zkUSVAP+2dR6Q3cDOk+cllq5E2dKqvDQ5Kak1/S45d8=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4913.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3fe4665-b0a3-489b-e11f-08d8a591e41e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2020 09:22:08.7631 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sNv+wtOPOqv6lKU0i+oKH4ZChkl0ML0jseFnXGOloYmSdQGbyF7lEeKQ+xwzCOXA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4206
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

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Regards,
Lijo

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>Quan, Evan
>Sent: Monday, December 21, 2020 2:39 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>Subject: RE: [PATCH] drm/amd/pm: bump Sienna Cichlid smu_driver_if
>version to match latest pmfw
>
>[AMD Official Use Only - Internal Distribution Only]
>
>[CAUTION: External Email]
>
>[AMD Official Use Only - Internal Distribution Only]
>
>Ping..
>
>-----Original Message-----
>From: Quan, Evan <Evan.Quan@amd.com>
>Sent: Friday, December 18, 2020 12:44 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan
><Evan.Quan@amd.com>
>Subject: [PATCH] drm/amd/pm: bump Sienna Cichlid smu_driver_if version to
>match latest pmfw
>
>This can suppress the annoying but unharmful prompts.
>
>Change-Id: I50bc5f9bd21572f51af4ff4c9e1946d1a441b714
>Signed-off-by: Evan Quan <evan.quan@amd.com>
>---
> drivers/gpu/drm/amd/pm/inc/smu_v11_0.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
>b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
>index e5aa0725147c..13de692a4213 100644
>--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
>+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
>@@ -30,7 +30,7 @@
> #define SMU11_DRIVER_IF_VERSION_NV10 0x36  #define
>SMU11_DRIVER_IF_VERSION_NV12 0x36  #define
>SMU11_DRIVER_IF_VERSION_NV14 0x36 -#define
>SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x3B
>+#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x3D
> #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0xC  #define
>SMU11_DRIVER_IF_VERSION_VANGOGH 0x02  #define
>SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0xF
>--
>2.29.0
>
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.f
>reedesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C3bfbf93798c14d0aed25
>08d8a5901db2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63744
>1385695003445%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ
>QIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=h0%2
>Ba4wg7Dl2zPQliE5WUpqDqLX8h4oVjTRBmw9lcnOA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
