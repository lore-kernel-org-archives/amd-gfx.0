Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5959C5CFC1
	for <amd-gfx@archiver.kernel.org>; Sat, 15 Aug 2026 05:53:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 619A210E111;
	Sat, 15 Aug 2026 05:53:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zpJCEmSn";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012052.outbound.protection.outlook.com [52.101.48.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE3C610E111
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Aug 2026 05:53:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3QOsrBiEBjGmUWnMwHQdfpgmmUCo+x6/N1CfwKlsvkUxTn3AwJrlyUR2WijsG6IMCAaNjtC7O4s971mYyELjIJciOZaw48iE0J+ZVwsTw7OFNwysOa8lGrHHDMFXm1F2wO+l4JH/Dqy32S+RluoppyD9DFEYGwChu9tzlWxRtjDkvO123jIKfl025S2CUn+VDU/wpD9llwDd68Y51KkNAYL9ngZS2rc6EPoN+s821VURP/6swNvPeCGMRIOvHvG0u20JGSOiiUQ1an1yuh4WVZWw9+VXR0EC8jD+b4tZ7KtqUwzhQTmW0YIfBUgLxts5TY+DsF2p0fOcrvi3NhC2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCOsQvIyt0XruOY7vBoO+BoUKYF2on3Xz6JSzNXG7Is=;
 b=Y/jNwSHo+e0IM1+I3HUJawAnddRjA+iwnNr7fzXCmBYwFRPx8git9uPezwtIKw+opagSJn8RoCaIfAXT/7+2rvxb3IimBUToTw0gwMU/eQFg2vzFBoNmYD8FjyCBD++dcKS9ouOi+bM5nm06T8PuZPf6ldX6f1snG7rfxyfh0hOM7nGIj0L1bDIZPMm2lCtWmTw0mkccpcGZYU71CQUigzlj2dAd3v6wkLcrSGLepCCSmk9i5Lmq5g/vTcnBGuK6pCsKNf7epNifOj5YKTOg8qHVTmbkLs4ovoDc4P1EBCWJhcSwzGsknm4rHWHlK/0sE0+9tKg2F/leYO+loIUgGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCOsQvIyt0XruOY7vBoO+BoUKYF2on3Xz6JSzNXG7Is=;
 b=zpJCEmSnQDo5EKt7cwDQteuOcpuDP9FFKrGLEn6BK9JmDzyG1QIn7bonlzsNOlTDzF71JZ3SbZjvEQi09CPqaExxoArXKt5hJFnQF6JI21zWAEdQcW1nxBSKA79UxiW6saHVxb4gYpFsAEU2szNRbMp/Z5VgR+WdUx6Cf5qfYGw=
Received: from EAYPR12MB999158.namprd12.prod.outlook.com
 (2603:10b6:303:2c1::15) by PH7PR12MB8040.namprd12.prod.outlook.com
 (2603:10b6:510:26b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Sat, 15 Aug
 2026 05:51:53 +0000
Received: from EAYPR12MB999158.namprd12.prod.outlook.com
 ([fe80::c52f:2856:964e:a4b2]) by EAYPR12MB999158.namprd12.prod.outlook.com
 ([fe80::c52f:2856:964e:a4b2%4]) with mapi id 15.21.0315.014; Sat, 15 Aug 2026
 05:51:52 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 099/109] drm/amd/ras: allow waking RAS processing without
 an event
Thread-Topic: [PATCH 099/109] drm/amd/ras: allow waking RAS processing without
 an event
Thread-Index: AQHdLDCBWtiVKabfy0yHlLDP4CYa0baem7FQ
Date: Sat, 15 Aug 2026 05:51:52 +0000
Message-ID: <EAYPR12MB999158FC50ADD92FBE3FC03709FCD92@EAYPR12MB999158.namprd12.prod.outlook.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
 <20260814210246.3067612-100-alexander.deucher@amd.com>
In-Reply-To: <20260814210246.3067612-100-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-15T05:50:54.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: EAYPR12MB999158:EE_|PH7PR12MB8040:EE_
x-ms-office365-filtering-correlation-id: c7565b13-e3e9-4683-5daf-08defa914e1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|22082099003|18002099003|10067099003|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: 7lMn4zARGboRJQ1dsgHwf3LNbCv43g5Qhg+g3nwCoMsBLm71YWCRm+I4KJ9myuQDEen7THGjQSY99fIephuceeYX3+i/5Co1XbPwfFPq7tNAa7PGPxTVkI5iCKIZnEawRuKIHqpd97RzRC/7uv8WhA+AEvkxxSTKCOSVq5yWX9l6acjXHVXRy0g2tmTX6m1tjbRyiJ+TO9LB0i+Fp3WZ31SgE5gwSTNjNquaP8pPFe61uCnqlUaViuHIB+5aP8CczlCGKq0mvNiV37qzZKQK4FIp07kYRxWm5irKl+uyqUnKL1XjMQGZV/gDRr9+sHfBrD4t23Ph6OQzcQSL2RVOgT2aCnIggYdUogKtby+9V+SN+qAkOF1WMDV8IBb7KxSt6CRhq7y5EgwEL2Ys6mNzajpbL2WcBHDngIWv3LpmEe6rvGYOOpwlzbaO2Bsydt7c3GavwP+BOJkx+grXI1XeGUX9+bXqLyGDB05o8ktcxjassXpjXoq3xkfJfLv1ShuoIu45FTgtaX4RmDDkDMLAjpxknKwxE0+wpqAxJmqNV8JON6o3dT7NbunIK6IdhIebJZN6z5o5Rfkxg46Lq94nDrZUDycexk8Csa3xwFIDRRCazyrIwOdIodZZoGYSPKhnAmViUd8EA+Y76lg2rQ0LXIO83o1vju4M0ZBeUItA6t6w5I8L+ni7r9I/QXY8HiXfN84l370yIlflPB4oy3TqBLcdBv7BDT3PLYuKjIhAtkI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EAYPR12MB999158.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1I34ah66pilDR+77PZXCfQQ1afldoMidQhrMuwFLG+Gaoqyb06wRMW99C/Ej?=
 =?us-ascii?Q?bxu8FaWZQe7rubJn/2gJPs4PbK584d4MdVlQyH3/9OxwCXRoukSPJMM17xzc?=
 =?us-ascii?Q?WNnZxUkq9I5MImk3mnQ9HfFKOx6L99IGZzVy0qbYYddhblxAQFpFfQ/gdaxO?=
 =?us-ascii?Q?eCWOOqDJF9x3IscmcK0U4nO7xqnhsvEU05KdOfDzzKdZX7fUGuNbRpCXTSo5?=
 =?us-ascii?Q?fAa7tpCSr63T5VCSAMXMAOzOG+1d+Rfm3Z4t41DC/egwrncQepcGRcDaAP1v?=
 =?us-ascii?Q?3LCgMzoLj3MHc2aYhXsOYV48+cuMbuR5UOEB6hghVZNxpX1BQXH8Q9iZqSrs?=
 =?us-ascii?Q?uBNJaeeuxpXIoO7rZxvxX70sgO20ZGOg2BSiKgQ6Wi7oP924ZbeO0ooWF2eF?=
 =?us-ascii?Q?Nzz2uAsi3VCVZpe4oDIUNsxyAsNa4odBMmQy0w+s9Crz4dE7wzz37ql552eh?=
 =?us-ascii?Q?x4hMPBqkyiYHUE4nw4TdSihk480lS1Qjoe316PU5QvoV8bM+RKbSM16MrWDy?=
 =?us-ascii?Q?sCrtmeaHkcCXd4oiOqPvKqbz9fk5cog8P41Iwj6EM7LIOoZB9tYo1dv6c6ll?=
 =?us-ascii?Q?lFliDrWLi8ehwYo9E86yIpX8p0ZegELmP0nrSaqBrydyqxjBb3vYP7XFHoGG?=
 =?us-ascii?Q?ErTjj/yyeeOrzFngmN27NhmOI3w5gJtNk2qvY7b42UpIiEHWJ6su11Qvxyb7?=
 =?us-ascii?Q?Ueiy2vONUjCWIE20NoMSwSCYnPLoX4PtF3NfCQug44TfvkF0TtR6psEURvV1?=
 =?us-ascii?Q?sERTbTRXjpCaa+dzPxo6MnqRYGb8KqIYKJTtj6szpVENJSX29BwlnrXiAnKZ?=
 =?us-ascii?Q?RAslTLvCH/JdzBdX0HuGQUlWqrYltf+nHf730Dnmx4PYU6BZgFIdP72wJrr7?=
 =?us-ascii?Q?WzEVjNWbkeLzne5NG9eHWzvmcaS/aSYHHSYm5BcwSh2WdEM70sOzfLeQ0l9o?=
 =?us-ascii?Q?w4Jje/O1fn3/J3S/lJozYzuO9Q1aj2MZz9zu2srhD4x7SMM3GBxYpKzsgXw8?=
 =?us-ascii?Q?E+ZjhKL4a8ungmZEX/SZI+7DDIKKuAkAt+xSQNTXuf3Z72YupjSVefywFrfK?=
 =?us-ascii?Q?/NGfH6U+I4wFYvF/qHGnHAMiy/F/rNyOG9yOAH6DCn96lBP3A3vbP4Lo7B1E?=
 =?us-ascii?Q?T7rA3mh/DJ1JPmGJf+3nqqKp2BD8coLuQjMnBU7mwZ4EpCtREVqrYRkw4B7U?=
 =?us-ascii?Q?DIMx06tkeORW/WudY2YolY1mK9nw+q4EfClf7segyXJdd5Mkv6v3CrAy5zhc?=
 =?us-ascii?Q?UfgOfFRCQUeelMx6iHVhp4Q8OlU5nU3R0iS2K7FwXUlI+Oo7Sd/6nOgvFZz3?=
 =?us-ascii?Q?lX427YtsjcsBuzAjF2KlGueN1De9b3r6uVZk9mILutYv0VBvTJ3nAJegiLQ8?=
 =?us-ascii?Q?eNF8HVbwIU0xQFv1KUwhtomY+Q1s8vVWL36N4QCaiSy+po5vyjf4H9ThLqrw?=
 =?us-ascii?Q?+zUWjvRa7flqYnwAQMzQeq61FYBu46EP2J5r+qaJNjXAS5WFIehDV+iVBIZx?=
 =?us-ascii?Q?EMsrjT6V/AwBE832AeTVcUvU3pJVfCASRUL3rrsI/JXglEtKTelCx1E+8YTR?=
 =?us-ascii?Q?Kin8nl4UH/cCKlrkgcorOLIL23Nq+JtT6GPfHHdgpcMWHY26143T3II9OZjL?=
 =?us-ascii?Q?VsclCGD11JtnO6tXL7Wcaox2onJG/u96SwV9952YoP9dF7AC+LtC+E6YOs/e?=
 =?us-ascii?Q?caYFxC58/KzVC8Lw1rPonrJHx5XvxvTcCbSCIAfY+18ozg6l?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: EAYPR12MB999158.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7565b13-e3e9-4683-5daf-08defa914e1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2026 05:51:52.0819 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ckicAKwKwx6MdZdI8DDTej2KJnlrhy+ytHVAPYw5d5GtY4iWj1OrBqZ8jxyYIJRz+WxsChyXeBRn+pXVyOOCeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8040
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

AMD General

Patch #99 ~ #109 are

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Saturday, August 15, 2026 5:03 AM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Xiang(Dean) <Xiang.Liu@amd.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>
Subject: [PATCH 099/109] drm/amd/ras: allow waking RAS processing without a=
n event

From: Xiang Liu <xiang.liu@amd.com>

GPU MCE handling queues bank data directly in the MCE FIFO and only needs t=
o wake the RAS processing thread. Requiring a separate event request preven=
ts this path from scheduling processing when no event object is available.

Permit a NULL request to skip event queue insertion while still incrementin=
g the interrupt request count and waking the processing thread.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras_process.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras_process.c b/drivers/gpu/drm/a=
md/ras/core/ras_process.c
index 395d10c94b195..f313f2021f243 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_process.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_process.c
@@ -311,13 +311,16 @@ static int ras_process_add_non_umc_interrupt_req(stru=
ct ras_core_context *ras_co
        struct ras_process *ras_proc =3D &ras_core->ras_proc;
        int ret;

-       ret =3D ras_process_put_event(ras_core, req);
-       if (!ret) {
-               atomic_inc(&ras_proc->ras_interrupt_req);
-               wake_up(&ras_proc->ras_process_wq);
+       if (req) {
+               ret =3D ras_process_put_event(ras_core, req);
+               if (ret)
+                       return ret;
        }

-       return ret;
+       atomic_inc(&ras_proc->ras_interrupt_req);
+       wake_up(&ras_proc->ras_process_wq);
+
+       return 0;
 }

 int ras_process_add_interrupt_req(struct ras_core_context *ras_core,
--
2.55.0

