Return-Path: <SRS0=y+Th=FL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D25C4361B
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 08:46:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3FED225A9
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 08:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3FED225A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FDBF89A74;
	Mon,  7 Dec 2020 08:46:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF44C89A74
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Dec 2020 08:46:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BE+fLw2RlT2Owp1dWoS7a+blNmZ96xT95zK3hRaXeomXlY3JFqiQfb83LP2/z+xjkiR7HozYysLNagcqsNtIKPna9gt59KAi3WgA7AQrVFM4nFmf4tsBOLI3MjmhDm0O6f347T4HGP2C6ot0HVO7l2bqEcjuydDRwkwpYq3nNqEpXj20FzpsyBTwMCdQSoNFqkjW0KxqTQLudgXS7fp4lQp+M7iKcb9pDaK4yn787iRo6LnhgRgRHiEAfeCOXclcLHiSt+FsgVMhu4YhJr4SJaCfqsFz+MLqYiM5aw3bd/1avVcQhQk7ek4+Q54oZdaAWuPRvaaYv0hLvkR0d5p5pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eU0338FdqTPQkzAPZXzhla1TMrk6tvvI+piKj9OTCqs=;
 b=aWevh6+JL9k0DuF/hDE15tPV0BHDfzarPb8C246mSzHMZXhKSKM3qc1ZYZ/aFH4Dgh4HitHcnVY8KN5ZZyFvXReylv7SCyY+f+R/wI+a/i0Mu68id9em+Je7e55kyxyWgFelrgpWT8BGbvVxFh97eO0MdMBq/l2qxTT78UWrIicj4CQIS0WcSX3y0Pp/b1IWvezB0h95qFRcxQnaXmkHu4kmFtyYVnokvS7xCuvxkxKtSiN/uJvCmgZ+bBMw+ElkGzwolnlEnYJLclcOMzLB8CwLrQst7/FyF/OsXpp8xPONLcH1+qEKumCfbn7fxyxqhbWo4RgWsQ+b1WdBXfTCzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eU0338FdqTPQkzAPZXzhla1TMrk6tvvI+piKj9OTCqs=;
 b=3gAWlKfvYrCDO9K3xclnFE8b4Nf0mG7fR5PPNhLTm+WRi9pGzSmQ4tNDtQJb6X0Nc8Vi+14m0xUyzp9hiWGyIpcMmHPB6HcBA7A6L0SEdhXsg0Ulmnvob38tRzSjz72kHkZ4LDFi4aZ8NHw5NNXtpg7rB+zjP82XahmrhHMEgoY=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3273.namprd12.prod.outlook.com (2603:10b6:5:188::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.21; Mon, 7 Dec 2020 08:46:55 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d%9]) with mapi id 15.20.3632.023; Mon, 7 Dec 2020
 08:46:54 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhao, Jiange" <Jiange.Zhao@amd.com>, "Zhao, Jiange"
 <Jiange.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/SRIOV: Extend VF reset request wait period
Thread-Topic: [PATCH] drm/amdgpu/SRIOV: Extend VF reset request wait period
Thread-Index: AQHWwzTQzhaWkvlnkkWAGmZgNdcBXqnrW48AgAAICQA=
Date: Mon, 7 Dec 2020 08:46:54 +0000
Message-ID: <DM6PR12MB4075C4877EA663F5886F6177FCCE0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20201125141012.301219-1-jianzh@amd.com>
 <BYAPR12MB3222F97D3A02992B2ED3FC7EE1CE0@BYAPR12MB3222.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB3222F97D3A02992B2ED3FC7EE1CE0@BYAPR12MB3222.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-07T08:46:52Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=3bb0fa55-27eb-4f66-930f-fff3fa8dcac4;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1b93b8ea-2926-49f7-05f2-08d89a8ca65b
x-ms-traffictypediagnostic: DM6PR12MB3273:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3273D5A2BFD9A9B5CB5E16ACFCCE0@DM6PR12MB3273.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vnWhr3MGsfhDZBKkeu9XTbXGnArRRBS04J5IPJFh7aouw9XbfIBbuJwAr0jR3mEU8HY0T3K8CjJJZ00XF3Su/lRq7AEJyv+m5M0W3wXdXaek2c8VsH8bFhCEk9+lyfzYprXFvJWF/xxpHhVUfJJdv24I97RarIectDxNFf8AwIayabbwuR3OyyMk6VVzLPj9Xa1kMZINQ52CSFFyzqn/ery1tzZcLnesh+a6BAxazv/zsxV0za2vLpATgwTzFaQQ6vp9A+lmGFcXJi3ztE+RPeq/t2HXFheW1t6UPs0F1eAxuo6CxrLnrPSt/ItFw+K3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(7696005)(71200400001)(8676002)(4326008)(5660300002)(316002)(53546011)(83380400001)(26005)(110136005)(66446008)(2906002)(55016002)(64756008)(52536014)(66556008)(66476007)(76116006)(66946007)(86362001)(33656002)(8936002)(478600001)(6506007)(186003)(9686003)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bDv4S259KZYaMlDyQ9UvtFN1XJpFBkIFmiPbXpmFaftwdX+s+56cFH2yL7Bt?=
 =?us-ascii?Q?/bX6BtWsL8m/Q2Tp6m+3p7y1kZLKo75Kx+Tl7b3jB3+UTSj9aIJUrNycvBV7?=
 =?us-ascii?Q?OS8jB6YpVnGync16X/igWGeGtKal2xQ4RWanwKdBQmhry938yPbqPqK/73Aq?=
 =?us-ascii?Q?aitQ6vJLA7hgd6pqclHNuANun+RUhJairnqhEc/3LLkcnn7ovKf1glIt5Tfk?=
 =?us-ascii?Q?ODghwK296g97Sh1QjCqQ3Hp+QY4PyB1fqcJNu9KKaZZDnerCFc6xNA99WRE7?=
 =?us-ascii?Q?mEDkiGHhtzyfa1KgJ9Pmieb/e0deTRT4syn4LqTu2mwR+WXRJejS4ZuYUTJ9?=
 =?us-ascii?Q?m2hdTQpwTwEbmHbD49hthlecgPQSYhzfMV/CsDHHXgtISCItfy67AGVKLolh?=
 =?us-ascii?Q?e9jQLo30hzk3jjIgnW0/3gNHyYL3CXo6q/tepXo/7HK35AhX/C7sWp+S8wyW?=
 =?us-ascii?Q?eouvCepjoQ9buD6OLLg0DvAEZ8MsiTrsG6VMv5D5hlx6Zqe21gqj9WZ5uFg3?=
 =?us-ascii?Q?Z4J6tUPJZpnTJ+EtaOBOyKxkCzpjMf4uQFYzQahKZYQTcoMFAQVG1hkNe5am?=
 =?us-ascii?Q?PW7MUcljShCpOKffuoghAaVN0QdWp6+bE2ThyPlsq4wewA7ukf15KQxw1UM8?=
 =?us-ascii?Q?B3CNfDQ/95YFVjhrSriEbR5bH73wqzRdSuIA2ouDTgPUYNjzdLT/LQ+2vxsj?=
 =?us-ascii?Q?JK48V/YN3IWtjjmQW1D9+440LRacfkCQ4Q9C/LmVcjwm26U6NwH2ajpHL9DU?=
 =?us-ascii?Q?SO2awMrtU9p8f6Zwev0k7RSNOViG+OqFbL/9BlqPdIAQ3pxIm8ZDRxCTNHUJ?=
 =?us-ascii?Q?4NLc8NOe0/zKgpcC8fslAdcFpy7DNHh4oikeM32bKjT/lkrlAIGM8Ut3PRJ5?=
 =?us-ascii?Q?8JbVdmHpkdKYlABfaZ8zWwOJ7F+ikrsPR/VPUc+1kIcIFrWfHNviZueeED7a?=
 =?us-ascii?Q?rTd9reAKazXEINR+evHeMHfYDfUndrCFeAh1LSvHCEY=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b93b8ea-2926-49f7-05f2-08d89a8ca65b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2020 08:46:54.8633 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J+fuRPF0K7iF7rymfVM2orcg6WVw3zAAqGyEVcHOLygbRtZSpUEi0OGcjCSCqL6jale70WsY9AyHgI/r2F1kBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3273
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
Cc: "Zhang, Andy" <Andy.Zhang@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>,
 "Min, Frank" <Frank.Min@amd.com>
Content-Type: multipart/mixed; boundary="===============0376938260=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0376938260==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB4075C4877EA663F5886F6177FCCE0DM6PR12MB4075namp_"

--_000_DM6PR12MB4075C4877EA663F5886F6177FCCE0DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

+       while (i < 11)

Please use macro to replace the magic number. No one want to play with the =
code which need some sort of guess to figure out hack setting or experiment=
al ones.

Regards,
Hawking
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhao, Ji=
ange
Sent: Monday, December 7, 2020 16:15
To: Zhao, Jiange <Jiange.Zhao@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Andy <Andy.Zhang@amd.com>; Chen, Horace <Horace.Chen@amd.com>; M=
in, Frank <Frank.Min@amd.com>
Subject: Re: [PATCH] drm/amdgpu/SRIOV: Extend VF reset request wait period


[AMD Official Use Only - Internal Distribution Only]


[AMD Official Use Only - Internal Distribution Only]

ping!
________________________________
From: Zhao, Jiange <jianzh@amd.com<mailto:jianzh@amd.com>>
Sent: Wednesday, November 25, 2020 10:10 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Min, Frank <Frank.Min@amd.com<mailto:Frank.Min@amd.com>>; Chen, Horace =
<Horace.Chen@amd.com<mailto:Horace.Chen@amd.com>>; Zhang, Andy <Andy.Zhang@=
amd.com<mailto:Andy.Zhang@amd.com>>; Zhao, Jiange <Jiange.Zhao@amd.com<mail=
to:Jiange.Zhao@amd.com>>
Subject: [PATCH] drm/amdgpu/SRIOV: Extend VF reset request wait period

From: Jiange Zhao <Jiange.Zhao@amd.com<mailto:Jiange.Zhao@amd.com>>

In Virtualization case, when one VF is sending too many
FLR requests, hypervisor would stop responding to this
VF's request for a long period of time. This is called
event guard. During this period of cooling time, guest
driver should wait instead of doing other things. After
this period of time, guest driver would resume reset
process and return to normal.

Currently, guest driver would wait 12 seconds and return fail
if it doesn't get response from host.

Solution: extend this waiting time in guest driver and poll
response periodically.

Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com<mailto:Jiange.Zhao@amd.com>=
>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c | 11 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 11 ++++++++++-
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_ai.c
index f5ce9a9f4cf5..d8d8c623bb74 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -187,7 +187,16 @@ static int xgpu_ai_send_access_requests(struct amdgpu_=
device *adev,

 static int xgpu_ai_request_reset(struct amdgpu_device *adev)
 {
-       return xgpu_ai_send_access_requests(adev, IDH_REQ_GPU_RESET_ACCESS)=
;
+       int ret, i =3D 0;
+
+       while (i < 11) {
+               ret =3D xgpu_ai_send_access_requests(adev, IDH_REQ_GPU_RESE=
T_ACCESS);
+               if (!ret)
+                       break;
+               i++;
+       }
+
+       return ret;
 }

 static int xgpu_ai_request_full_gpu_access(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_ai.h
index 83b453f5d717..20ee2142f9ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
@@ -25,7 +25,7 @@
 #define __MXGPU_AI_H__

 #define AI_MAILBOX_POLL_ACK_TIMEDOUT    500
-#define AI_MAILBOX_POLL_MSG_TIMEDOUT   12000
+#define AI_MAILBOX_POLL_MSG_TIMEDOUT   6000
 #define AI_MAILBOX_POLL_FLR_TIMEDOUT    5000

 enum idh_request {
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_nv.c
index 666ed99cc14b..0147dfe21a39 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -200,7 +200,16 @@ static int xgpu_nv_send_access_requests(struct amdgpu_=
device *adev,

 static int xgpu_nv_request_reset(struct amdgpu_device *adev)
 {
-       return xgpu_nv_send_access_requests(adev, IDH_REQ_GPU_RESET_ACCESS)=
;
+       int ret, i =3D 0;
+
+       while (i < 11) {
+               ret =3D xgpu_nv_send_access_requests(adev, IDH_REQ_GPU_RESE=
T_ACCESS);
+               if (!ret)
+                       break;
+               i++;
+       }
+
+       return ret;
 }

 static int xgpu_nv_request_full_gpu_access(struct amdgpu_device *adev,
--
2.25.1

--_000_DM6PR12MB4075C4877EA663F5886F6177FCCE0DM6PR12MB4075namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheader251902e5" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (i &lt; =
11)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Please use macro to replace the magic number. No one=
 want to play with the code which need some sort of guess to figure out hac=
k setting or experimental ones.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Zhao, Jiange<br>
<b>Sent:</b> Monday, December 7, 2020 16:15<br>
<b>To:</b> Zhao, Jiange &lt;Jiange.Zhao@amd.com&gt;; amd-gfx@lists.freedesk=
top.org<br>
<b>Cc:</b> Zhang, Andy &lt;Andy.Zhang@amd.com&gt;; Chen, Horace &lt;Horace.=
Chen@amd.com&gt;; Min, Frank &lt;Frank.Min@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu/SRIOV: Extend VF reset request wait =
period<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-family:&quot;Arial&quot;,sans=
-serif;color:#0078D7">[AMD Official Use Only - Internal Distribution Only]<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p style=3D"margin:5.0pt"><span style=3D"font-family:&quot;Arial&quot;,sans=
-serif;color:#0078D7">[AMD Official Use Only - Internal Distribution Only]<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">ping!<o=
:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Zhao, Jiange &lt;<a href=3D"mailto:jianzh@amd.com">=
jianzh@amd.com</a>&gt;<br>
<b>Sent:</b> Wednesday, November 25, 2020 10:10 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Min, Frank &lt;<a href=3D"mailto:Frank.Min@amd.com">Frank.Min@am=
d.com</a>&gt;; Chen, Horace &lt;<a href=3D"mailto:Horace.Chen@amd.com">Hora=
ce.Chen@amd.com</a>&gt;; Zhang, Andy &lt;<a href=3D"mailto:Andy.Zhang@amd.c=
om">Andy.Zhang@amd.com</a>&gt;; Zhao, Jiange &lt;<a href=3D"mailto:Jiange.Z=
hao@amd.com">Jiange.Zhao@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/SRIOV: Extend VF reset request wait peri=
od</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">From: Jiange Zhao &lt=
;<a href=3D"mailto:Jiange.Zhao@amd.com">Jiange.Zhao@amd.com</a>&gt;<br>
<br>
In Virtualization case, when one VF is sending too many<br>
FLR requests, hypervisor would stop responding to this<br>
VF's request for a long period of time. This is called<br>
event guard. During this period of cooling time, guest<br>
driver should wait instead of doing other things. After<br>
this period of time, guest driver would resume reset<br>
process and return to normal.<br>
<br>
Currently, guest driver would wait 12 seconds and return fail<br>
if it doesn't get response from host.<br>
<br>
Solution: extend this waiting time in guest driver and poll<br>
response periodically.<br>
<br>
Signed-off-by: Jiange Zhao &lt;<a href=3D"mailto:Jiange.Zhao@amd.com">Jiang=
e.Zhao@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c | 11 ++++++++++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 11 ++++++++++-<br>
&nbsp;3 files changed, 21 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_ai.c<br>
index f5ce9a9f4cf5..d8d8c623bb74 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c<br>
@@ -187,7 +187,16 @@ static int xgpu_ai_send_access_requests(struct amdgpu_=
device *adev,<br>
&nbsp;<br>
&nbsp;static int xgpu_ai_request_reset(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return xgpu_ai_send_access_requests(a=
dev, IDH_REQ_GPU_RESET_ACCESS);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret, i =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (i &lt; 11) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D xgpu_ai_send_access_requests(adev, IDH_REQ_GPU_RESET_ACC=
ESS);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; i++;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int xgpu_ai_request_full_gpu_access(struct amdgpu_device *adev=
,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_ai.h<br>
index 83b453f5d717..20ee2142f9ed 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h<br>
@@ -25,7 +25,7 @@<br>
&nbsp;#define __MXGPU_AI_H__<br>
&nbsp;<br>
&nbsp;#define AI_MAILBOX_POLL_ACK_TIMEDOUT&nbsp;&nbsp;&nbsp; 500<br>
-#define AI_MAILBOX_POLL_MSG_TIMEDOUT&nbsp;&nbsp; 12000<br>
+#define AI_MAILBOX_POLL_MSG_TIMEDOUT&nbsp;&nbsp; 6000<br>
&nbsp;#define AI_MAILBOX_POLL_FLR_TIMEDOUT&nbsp;&nbsp;&nbsp; 5000<br>
&nbsp;<br>
&nbsp;enum idh_request {<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_nv.c<br>
index 666ed99cc14b..0147dfe21a39 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c<br>
@@ -200,7 +200,16 @@ static int xgpu_nv_send_access_requests(struct amdgpu_=
device *adev,<br>
&nbsp;<br>
&nbsp;static int xgpu_nv_request_reset(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return xgpu_nv_send_access_requests(a=
dev, IDH_REQ_GPU_RESET_ACCESS);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret, i =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (i &lt; 11) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D xgpu_nv_send_access_requests(adev, IDH_REQ_GPU_RESET_ACC=
ESS);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; i++;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int xgpu_nv_request_full_gpu_access(struct amdgpu_device *adev=
,<br>
-- <br>
2.25.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB4075C4877EA663F5886F6177FCCE0DM6PR12MB4075namp_--

--===============0376938260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0376938260==--
