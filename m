Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29DECD5BD5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2026 14:30:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6925510E279;
	Wed, 27 May 2026 14:30:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DGttitG7";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012065.outbound.protection.outlook.com [52.101.48.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC2D010E279
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 14:30:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHonsJQ48alM8o6Cz8Zx+aUZj/XWyB8kSGRwkPE9unYz+f3zIwMfSwBpgTL2Uyueh2CcNHvGuCGwiI6YfBdkqD8CZBkHros7tFx6TiWlTDXSBWGDzGoAkZJGbe/vZBCViZBq+LDcXmhZyMwYg9pCVNOz4n01+lo/HsatxzP5uXAdlD5xhS/lXaDiCgwvbgOuMx7wXZfr7I0CXbPEiC8z07wMUOOzCXIPag78LfCFnbFTtpeswdVBSZ8wK28b0rrQQFV4unsE3/cPTZtjk6LAYQXRFYmJHm6Hrp7PxW28NqIKdfzj9djZZSjoX2E9tlYzj/w+nVKr02BJluE+GZ4Fmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mz6VxRgIJopgUInj7KeCSPKH09fs8b7FqGjW0+XLJZg=;
 b=F/pPPdZYxaM71s5eVkqFbVYRsjrEq6UtHsMBnhKRj0lwT11F4k8bHVOGfpq/TV4Hejf4sNxxYPu9rY2PqI9HjdPaLyBJ+FvAxrKXQ1wbF0iwH03far8X499I3M4HerON8ZMjKEmQQpx2oslZtpNbD5CrJJOBqVrIp3XjXZdx5b0/6ZmsfIPq8Ov8HHQWJWzJSDLTsnP+HRiRQTBU/TCBJUrluDqUPD8JRIYciUAic9XyaB/pntQOjehPRTXj8dD8bAsEQBg4fIuwcDx+6QeBXQCzzNCHchSGAdxdL1uGIdvE86eN6AP9Pg0Xsd9sYbeDWX+T2zQZokPmWnYO5bJcIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mz6VxRgIJopgUInj7KeCSPKH09fs8b7FqGjW0+XLJZg=;
 b=DGttitG7+G6z8XFV4M5PcGpEISuyJsdrFOUX5YbEitxEmDBU2wdsgKuIyd2Rj3wAwd5BcZxEB7vJjZ14Ygy27XyA6X0lwYrZ/sETFv4pve1yBno9PFb0glnFdaxEId2/wRSgbLnP0MFy7MJONqWJKIaPIDsV/eqrpMGCEYaS8H0=
Received: from CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8)
 by DM6PR12MB4204.namprd12.prod.outlook.com (2603:10b6:5:212::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Wed, 27 May
 2026 14:30:51 +0000
Received: from CH3PR12MB8658.namprd12.prod.outlook.com
 ([fe80::46bc:93ad:2b41:b7c9]) by CH3PR12MB8658.namprd12.prod.outlook.com
 ([fe80::46bc:93ad:2b41:b7c9%5]) with mapi id 15.21.0048.016; Wed, 27 May 2026
 14:30:51 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Clement, Sunday" <Sunday.Clement@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH]  drm/amdkfd: Add bounds check for AMDKFD_IOC_WAIT_EVENTS
Thread-Topic: [PATCH] drm/amdkfd: Add bounds check for AMDKFD_IOC_WAIT_EVENTS
Thread-Index: AQHc55p6aygg0oFwqESStq8geWC5CLYh+42Y
Date: Wed, 27 May 2026 14:30:51 +0000
Message-ID: <CH3PR12MB8658E7B4ECB25BC091ECEF8C8C082@CH3PR12MB8658.namprd12.prod.outlook.com>
References: <20260519141808.2746913-1-Sunday.Clement@amd.com>
In-Reply-To: <20260519141808.2746913-1-Sunday.Clement@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-27T14:30:50.182Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8658:EE_|DM6PR12MB4204:EE_
x-ms-office365-filtering-correlation-id: 99e6dc65-7876-44b1-5523-08debbfc8d68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|8096899003|56012099006|18002099003|22082099003|6133799003|11063799006;
x-microsoft-antispam-message-info: WpcYI1Qna1ZEXJpZIEce2j58phOQ2mNP4knELwVoniVKhYz8/4fGWCkcdzTQweloq3dC0047IkQ/drfhJePo+jE9Py1KDhqTEl6hTcF4W3JQ0pzYPnxlpylPWH8ozlRlv6XGUSVKGxYCWC3pA9pi7+vpQqcPCIOzWcenYozkRMWMFBeBYb/OaMzfq4hIXBQgAsg0mi8n6EhzCdHeFBT3pzU7k78NzgbCW4j/QCl60059scX7YRRHnYPPA2rzO39Y+CUOztLPYVE5bFGIoJESOJ7H9Vsw9XIulSfRNlKXHsj8fQfdLOahPHGZ7MTIyl4XETljTmYqRgz2lK3Lnpl5AIP5C9lO8cFrGBMR1POIAU3AxvAjQvBBN3Tg0gvjI+K8jufkIXEF8xv1I6cFo8mZJM7Y92+97vFFa7Lh2tuV9M3to2sEqgy8pbiAfCi4MlR9QIviuDxmR+KBdhD+CT+ucQ62KLni4T5bkT7ZOirAD3loON8CRiSVoWf5J0/i+GsKaLpFjPFLiuzzIO0XX1y91y7d2mDfnfJq85FDUQqXzUPxXnneAnHcK5IwGXD6SCuqndSqmfQXZIJrPo7EyVi58GLqkaDDR3IABKOlvmZEzM0+BgQxFcJ3Sz7eeXZhEmWueOlsDaqaBcYabWpVsJVua9qNJVs18vGGIGTq0rAtbJrUoJw58riBS1SyaXmW5ZV35FiVq0Ky4btF46pW6e1EKscNEohxGZSftjh78XCJGGhigZ/1GOztc8FqZs+Fw5xw
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8658.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(8096899003)(56012099006)(18002099003)(22082099003)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2Mnf3Sb12HkQk4XkSVZf+Lp/DWiJ+5f2pse6ecYTnMuIYcgSFrgm2rHHlKS5?=
 =?us-ascii?Q?o4fy4BWHKoF2YMqRfntaV1PRDgyZqoSZfLnv3cC0PvDCUai6JMAPzDA8/4dI?=
 =?us-ascii?Q?rG/jt66WIxgZnYyuj6ZxhVzq+PFGzG/NPwf68/mF/X4EH7cCSxmzQo9p15/p?=
 =?us-ascii?Q?fIUGgAknKUStqR0Q4N7I7ywGJT5zUhekcygsfPdYaVqtzc/V/70/p9w8lHMQ?=
 =?us-ascii?Q?Tn79IwebNIoLaN1NuVACuFdSbBq1NcL9yy1yJth8Jege43zl7PkE/CNqQpjA?=
 =?us-ascii?Q?uxrkFz5fEAwRdeOfqAjeZFWQbUJ2xD7jkfswqDpa6zwVuwcLP5OTAZx7OUb4?=
 =?us-ascii?Q?IKkkxcW/GTQAUGQlgsJ4NQZ9x+uUA2bQSPi8AXQsKo5ffT4gxDnQPDypuaBB?=
 =?us-ascii?Q?LF0e9mqZrhBsyELwD9wCFn0kpETXiQJI8ladv0xsDZ+qLn9z3CmEwR3IQrlW?=
 =?us-ascii?Q?TSsXQE8oagorL5Wbr5ovmpA3bBlk5Vru5Vhwe0/cDLFuT3JgW5Q8QC4C3sKP?=
 =?us-ascii?Q?jtaeGQins2E+W5WDJab7PtWSdPDbb/1LLZowbIxK5sQmrFPiCEBBXx/xBbts?=
 =?us-ascii?Q?KU2Mmm+Vbg7c8ZdQsNSEut96w/EM+xELUV5kSqo0txXTbd/hq2fg4yaPcIyM?=
 =?us-ascii?Q?yblcNCoKnE/kCgSmZwazvDD58khIaOTtwxCxoiAI0Jj1abv/atbXTHYhbhPX?=
 =?us-ascii?Q?ePi/JTjIktcEV+qUUJWrO6wSqkNtdZPdsTPkCZQtRSvb6Wq18IK6938DMA20?=
 =?us-ascii?Q?uIpPMte31Wj8uw3Dusgx7Shcio5m3KgbIKjtJIxmAGECDdyKfkpyu67Qc9Q9?=
 =?us-ascii?Q?A7EHqmZ1C+O8Vnn2Km/sg3sPeV/gmQnxJXLTCbz7Vjk6eo3yv/vwtiSzvsFP?=
 =?us-ascii?Q?PvKObG01J5G5h3UEVb0MQ0DDruPIVBVkje4Jz9N0DTjZpJgmTctBogWascnk?=
 =?us-ascii?Q?6a6QQzx5rkRVxJs/WAT6yk8kDNxsPt/12/4dT5FG7OQ+nBjBniOHOCoWmUo/?=
 =?us-ascii?Q?uBD87yd8/8+csClAzc1MOHiYEUapND0V1Vj8r7PZ6/M9bBB2qiQGgJpJ2HSU?=
 =?us-ascii?Q?E/85RPa52aZmPzBBHY96LrVDgDSo4IpaIbdneIouS4lvAivTOjxIQrMzWMam?=
 =?us-ascii?Q?CTMo+kCzywQLUXdQXSIUGJrmofWIaRefBPfO8xYp3Xu+Ful8LZWaQxYHHMdk?=
 =?us-ascii?Q?ipV9CAIEJA8J4DGvOn3/t4UomwjPz26wHk8/uOOx91M8dhdErLvcfDVzqmba?=
 =?us-ascii?Q?SBmLxInUTSfR0l5FNJYSnjiWVSk3iTdfBE4Hf4UIHeBvBJf8kqOVv2bX6iJk?=
 =?us-ascii?Q?Ahfhoy9ZLJQRmmIZq4im/WaqalZ10P2PfwegdSQFwpWTQFJFHK4EoUCs5d+j?=
 =?us-ascii?Q?5ZW4HPCYQRvy08Su3rDZx9tLeG8zY+S/9EFIiHBZuxny834S07bPlRhFtsC+?=
 =?us-ascii?Q?36KwfUa2arCW08BYavD7JF3yDImH6+ITg8Uk/Hwkq1WFwVu+QNtNw16MnqUb?=
 =?us-ascii?Q?d3GMy11+C44258WM67ucJzA407jTXzcVpEtdDQwJGrwJHFy0uTxyYvLXJF5i?=
 =?us-ascii?Q?19Gmdvc6QXmdYGrnAejGS4NLFjJNPIyKEio9nG7SL0tz+zkNz2UgvpYJI0sN?=
 =?us-ascii?Q?OP5V5PZYH3fpwkUDq6x5kWIIrXXexq/B+SiF9R2b8Mzx/2wScfAcWPMVxID+?=
 =?us-ascii?Q?BJsIVT89AVrbMImrBwXsI628YNFkNqpgJfVydonghWGKuYIk?=
Content-Type: multipart/alternative;
 boundary="_000_CH3PR12MB8658E7B4ECB25BC091ECEF8C8C082CH3PR12MB8658namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8658.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e6dc65-7876-44b1-5523-08debbfc8d68
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 14:30:51.1396 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zpxEqZ8KjKvQ4S4+gMfxNU2r+EqzYByk7gKWJS413aZgsww+vbA6mg40eKDXsobaIpIm/ChQa0dmvc69jlpkrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4204
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CH3PR12MB8658E7B4ECB25BC091ECEF8C8C082CH3PR12MB8658namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

________________________________
From: Clement, Sunday <Sunday.Clement@amd.com>
Sent: Tuesday, May 19, 2026 10:18 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kasiviswanathan, Harish=
 <Harish.Kasiviswanathan@amd.com>; Clement, Sunday <Sunday.Clement@amd.com>
Subject: [PATCH] drm/amdkfd: Add bounds check for AMDKFD_IOC_WAIT_EVENTS

The kfd_wait_on_events ioctl passes a user-supplied num_events parameter
directly to alloc_event_waiters() which calls kcalloc() without validation.
This allows unprivileged users with /dev/kfd access to trigger large kernel
memory allocations, potentially causing memory exhaustion and denial of
service via the OOM killer.

Add a check to reject num_events values exceeding KFD_SIGNAL_EVENT_LIMIT
(4096), which is the maximum number of events a single process can create.

Signed-off-by: Sunday Clement <Sunday.Clement@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_events.c
index e9be798c0a2b..83edc4af77b5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -799,7 +799,8 @@ static struct kfd_event_waiter *alloc_event_waiters(uin=
t32_t num_events)
 {
         struct kfd_event_waiter *event_waiters;
         uint32_t i;
-
+       if (num_events > KFD_SIGNAL_EVENT_LIMIT)
+               return NULL;
         event_waiters =3D kcalloc(num_events, sizeof(struct kfd_event_wait=
er),
                                 GFP_KERNEL);
         if (!event_waiters)
--
2.43.0


--_000_CH3PR12MB8658E7B4ECB25BC091ECEF8C8C082CH3PR12MB8658namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Harish Kasiviswanathan &lt;Harish.Kasiviswanathan@amd.com&gt;<=
/div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Clement, Sunday &lt;S=
unday.Clement@amd.com&gt;<br>
<b>Sent:</b> Tuesday, May 19, 2026 10:18 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Kasiviswan=
athan, Harish &lt;Harish.Kasiviswanathan@amd.com&gt;; Clement, Sunday &lt;S=
unday.Clement@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdkfd: Add bounds check for AMDKFD_IOC_WAIT_EV=
ENTS</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The kfd_wait_on_events ioctl passes a user-supplie=
d num_events parameter<br>
directly to alloc_event_waiters() which calls kcalloc() without validation.=
<br>
This allows unprivileged users with /dev/kfd access to trigger large kernel=
<br>
memory allocations, potentially causing memory exhaustion and denial of<br>
service via the OOM killer.<br>
<br>
Add a check to reject num_events values exceeding KFD_SIGNAL_EVENT_LIMIT<br=
>
(4096), which is the maximum number of events a single process can create.<=
br>
<br>
Signed-off-by: Sunday Clement &lt;Sunday.Clement@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_events.c | 3 ++-<br>
&nbsp;1 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_events.c<br>
index e9be798c0a2b..83edc4af77b5 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c<br>
@@ -799,7 +799,8 @@ static struct kfd_event_waiter *alloc_event_waiters(uin=
t32_t num_events)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_event_waiter *e=
vent_waiters;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
-<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (num_events &gt; KFD_SIGNAL_EVENT_=
LIMIT)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; event_waiters =3D kcalloc(=
num_events, sizeof(struct kfd_event_waiter),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GFP_KERNEL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!event_waiters)<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_CH3PR12MB8658E7B4ECB25BC091ECEF8C8C082CH3PR12MB8658namp_--
