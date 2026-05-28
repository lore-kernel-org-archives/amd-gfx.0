Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE151CD4F54
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 13:19:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ABAF10F17E;
	Thu, 28 May 2026 13:19:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RTOb2aM4";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012016.outbound.protection.outlook.com [52.101.48.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2928D10F174
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 13:19:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=br7NNslbR5ZyrS+HgyIE8xzodm+1pPpcXPAkOBjifNhyQTXCrX9REPA+dqwUu4dXBfvjfDv9uW3S7Z+Gy5k8uGX1ixw8CTjcpkNo0m3sokGl56hxU9gQvLn/iOcvOhUnNCGYBe2oh96MFMqJPXj7CwioRCldUmbr3plE/jQAcxJyqP815HDwABkDR0Fu+tQpidhCX8E15s0UzZOSu4XIZ++JnxBlVrPbZKaIDXkCjwghCFKKYlR2g3KlHWoTfJR9gdF156Opf2bOQS2GJaEdmWgAiEUf9odpG7HIw9pUang6Tais5wP7L+GBdb4+WQAgK8WWnPHedv5a9h4StjJSHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUJposYkNTNe+uppxmTkFCQWJtA64WOAoUQzQmdFRaw=;
 b=cSLcbAf86UpMIMvd5m5NxTCROrwUV2M1t/TWxOt/fTWuncx34/kjsDYgY/nUaamxVKqxvO5Xjdpd2ycueE+m3nm83P7rsAcYyAbbMJkTlOUE2jn7Qw92TGT8Eg+lEd8J8Bl6+HJOeuEa8gQx4HDB8wldhCxDEssr0VxY80fZwkjwdouZEQ+f5VKTEZ2JrUjvEayIKmLsx8Vd+h3mEcI8i/M4lTB/fW1n7VIHJPDqvLW+zMS0hG24hsgtzzyc3i53EuFIcNZU3rHoAje++P2DrLvA18trRJuDl+IDvhzvVqAdLRk5TOWnexVvHSjYej64NjCMuGYXQcp78N4m8mLd7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUJposYkNTNe+uppxmTkFCQWJtA64WOAoUQzQmdFRaw=;
 b=RTOb2aM4FwpZdtXPOMd7jju3bGrgPvRx7efY6oB3jYW5ujF85pBvxBzTOlCsIjgjcxWIvqJwiYiMan+Tz+PzMwRpt0JeTG+SN5236ABOHgzLlRMB6GniK7PtzlWR7ZqCyHBgnfykYCqYP2eNNOfIhKHAn2DbUK4+VMUn/G3MJq4=
Received: from SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15)
 by CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 13:19:14 +0000
Received: from SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec]) by SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec%7]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 13:19:14 +0000
From: "Francis, David" <David.Francis@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH V2] drm/amdkfd: Check bounds in
 allocate_event_notification_slot
Thread-Topic: [PATCH V2] drm/amdkfd: Check bounds in
 allocate_event_notification_slot
Thread-Index: AQHc7qRw+rNYUB90uEGwlwIps4m4OLYja8i3
Date: Thu, 28 May 2026 13:19:14 +0000
Message-ID: <SA1PR12MB8144C4FBBF4760E4177BAB8AEF092@SA1PR12MB8144.namprd12.prod.outlook.com>
References: <20260528131755.1776615-1-David.Francis@amd.com>
In-Reply-To: <20260528131755.1776615-1-David.Francis@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-28T13:19:13.702Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8144:EE_|CY1PR12MB9697:EE_
x-ms-office365-filtering-correlation-id: 876328a9-5890-4be6-e7f3-08debcbbb6cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|38070700021|56012099006|11063799006;
x-microsoft-antispam-message-info: ehG8NIdohW7NgpovDn/xer8GdQDMBWDkt7n3psQUxD4io1YU8SG32zDDKJzFrh4FRgEP0N+dJ4iug87uxZ0APP7lw5ruFmSxQEGNNsgOw4N48cD2873Y4FZPeuAYFKp0nGdeVoZESOw0Dibip5m7rFQc3GzQMvREFMhstsXijtW2oNGMdmQAzWtslgYBsPJigCoIQOR3AHeOWzWYs4v2FAPZSKB23PnjORKLL60PAeWj1tPG3w3tEdNUaK0OB6uvWcgm62hCcS4chTEuV8BkLcqrP45TDFxPxvQywdhF7FWaikyD0k/BOrg6q4sBJvJxCQ4MmoGxZV2A15HTVu7ZvpUUZ/QfRtOQmrDs4oU82actrqksqYoMVMD7R7wQCq3slMRZ8hg3sZ1XWSGsBdh/tZk8Xavdgi2Vf40/xeBFOm/2yIrNMvvxClhQl1ss14lFlO0xXdk6RPwbSJ2baXVRZv2v07SylmSAO7saIjxmU8yefD2m4mJZzTcK5uP23PSngA+1ooVBXJkY+6UGBn/uLCQvUcT1Tx4DYzNjtYV0afxuldYa3NXcce8nMVv7JKKJdP88RkiD5J8JIbQyadw9825KLIEHI0cqJ+TnFHDZxoEYUjB54jqEUmsLldSXEjr0f2dvTAESRsIpHnHDZlP1mZ8wZyIrV3n16loyXkLFYiY6C4T8t5ua98OcJnoSig5crtsbqPGzvZ0fzoheoDOeBEVbXZh2fhbnFy/M1/88iyBtCNjbQabm8rnDP7xFjHiF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ezJWANKRs3auXFdkxE0qZAmu6OtP9w3ILi3k1jDaXQtgXxlWv5n0f+AfE/zn?=
 =?us-ascii?Q?hafkRRUqWqALlkMJXXyIl+19XwL25mXireJ5cXApI49/19qdXUFUqWbotqtG?=
 =?us-ascii?Q?ElgjzWgeOopA2jPmd8nB8il4j1ePwcvluJYxDo7zoECC2TR1RVDONh4pe4LH?=
 =?us-ascii?Q?gfWQkr0Xr1Fy3tObTFVKD8VWt0TD95r3ATCgtBvyKA6e+VLoqL/Bt5utIcMC?=
 =?us-ascii?Q?ED9dnfXtfOR2zdbXvYCmEsQ9VsIrnxjl3RjH6+iKFo2wJVwygJ42NfHrU/4G?=
 =?us-ascii?Q?a5ParvhHD4yKRTquGCrpjLW6wNOB/3rT9RgXJSt+hBWLYtFzRvgt6nco6O0c?=
 =?us-ascii?Q?2ZybZ1COb7AiCTZ1PEvhWI63kplWZ2gf4eUlIoTPKiy3jeocbRFpyl2LWaxl?=
 =?us-ascii?Q?o2q/2GUyGFmcUONH5dpvAzAg0Q1YAu197/87GBfjzNvOcDD9WZZxO1/Uua8N?=
 =?us-ascii?Q?+IC87LR7fYNEFNr13/3SpevoRSiICpAGIetWOMy0D6bixYZU9EwCrdytSgX2?=
 =?us-ascii?Q?bVSWcpI1wpLbw3yrRd65wru3NKHX+1saGqSzyEZMER+IObyCrba572M5qt4n?=
 =?us-ascii?Q?iZS47twBd4VAB1Pmq1WNCQtUk93SGDrKAhsgf60EBQQOVgXHnohE7OmjhUeS?=
 =?us-ascii?Q?tWX63lIhroBTgTa+dVVxzGesTXOoiotyMvJVOiyrOR2PvIMW2d6gVFlO5saC?=
 =?us-ascii?Q?gydt3WKmInbr4RksI7WjbKv5Yl/FG68gi/iJypLZxHcgFQAzCjOjy2uJSsXU?=
 =?us-ascii?Q?RpQz9vqAWRprhJQkEX2boGZw5S6CdxWV4a4VJNQl4/rj45Jjtj/iVljPF+wr?=
 =?us-ascii?Q?9qrMxcqUoILXvjynUQb5WjMc97QV4JMwEgvIUYv3tz08017YFjOKjxzcrq5A?=
 =?us-ascii?Q?FfIXHvDwRAAcVintfhxkeVilqfHxKKqrQ8LMeKYM97pR8Fcy1VmzM4V76KWo?=
 =?us-ascii?Q?DtTStIAsHc6/U4AqZ+wnNYqeIZMDNHEJLlY8bJJ1d32CsFis/fadtAizzBF3?=
 =?us-ascii?Q?mJFxLmuxa7ZwhI4UBUPLvRw5KyLfJNdcKMMEasfEW+HAqaJCGMiKHeyk2CEU?=
 =?us-ascii?Q?x0ny9dgaxXfh9vIB0ivOQxJZvLVia0fYv+Krx9Zmj2Jkic9mGLnyJk4Q0Hje?=
 =?us-ascii?Q?wiLF3b09uifv7yRX5W+dHwoFvEVogKHEdVhHRlWIutuRnSMNuCivHtdAunG2?=
 =?us-ascii?Q?+6/k0WVtSCQWoMOR0ywGvQjV5bzHhC86AX2OnmmoXpdPDT4JLi5xGDYXah7n?=
 =?us-ascii?Q?xzHSq61x/s5C7SLaJ76BS4U6Dk+FqC2JESzvrOmDAo/whPQWix/OMZBNk+te?=
 =?us-ascii?Q?SZHaYVMhVheT+5B9gqkFuPPgi1ZLWKAyE8pRdKrLyuP9BvLguJc5pz2gzaC0?=
 =?us-ascii?Q?IvDRhXO1JhI9Tia8LspRqW/Imm1BJ4LbKmLnElz4AkltQHKrSvaoEzKKTfRB?=
 =?us-ascii?Q?8ONPoewjJava2aQC4guvgblShBkVz1O3VpEgnXjyWHIxypMyxxIqB/CujozM?=
 =?us-ascii?Q?7CaDk5pv3uES3/fwi020j4vLtYajZ5zy2vQMpUbRADWRQ8N4oIM/AwhvHKDy?=
 =?us-ascii?Q?vRyluIr7oWoFoN0Cgj7DYHICd0Q1k7uopnDYzEc7T2u0iVpnA/AeURuOT5ix?=
 =?us-ascii?Q?PPhEmAAe9oe1HCxNelAir0FcOIQMT0Fs/+taloSTqP5WAu5ypihQKpn2S1Ao?=
 =?us-ascii?Q?bYF071XTdM4NuEwnZIrg85Q+0y3fSboIcu1eS+FA4Mw+Zv8b?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 876328a9-5890-4be6-e7f3-08debcbbb6cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 13:19:14.4268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /V1pJG2/DU4GjXPpuJqCgoSaJnzascR8elw7Ielzf548Vtx1E51PadjTv+irgqBT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9697
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

> The valid event ids go from 0 to signal_mapped_size / 8
> (usually 256).
Whoops, meant to be "from 0 to KFD_SIGNAL_EVENT_LIMIT"

________________________________________
From: Francis, David <David.Francis@amd.com>
Sent: Thursday, May 28, 2026 9:17 AM
To: amd-gfx@lists.freedesktop.org
Cc: Francis, David
Subject: [PATCH V2] drm/amdkfd: Check bounds in allocate_event_notification=
_slot

The valid event ids go from 0 to signal_mapped_size / 8
(usually 256).

allocate_event_notification_slot has an option to specify
an event id to allocate at, used by CRIU. We weren't checking
the bounds on that value.

Check them.

v2: Lower bounds check is unecessary because of idr_alloc
already rejecting negative numbers. Upper bounds check should
be KFD_SIGNAL_EVENT_LIMIT since the signal mode mappings might
not yet exist

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_events.c
index e9be798c0a2b..850d6befeb6d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -107,6 +107,9 @@ static int allocate_event_notification_slot(struct kfd_=
process *p,
        }

        if (restore_id) {
+               if (*restore_id >=3D KFD_SIGNAL_EVENT_LIMIT)
+                       return -EINVAL;
+
                id =3D idr_alloc(&p->event_idr, ev, *restore_id, *restore_i=
d + 1,
                                GFP_KERNEL);
        } else {
--
2.34.1

