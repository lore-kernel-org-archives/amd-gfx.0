Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2EBC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 22:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A518260E08
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 22:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A518260E08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC6106E453;
	Thu, 20 May 2021 22:58:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA4C889503
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 22:58:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEctiskcnf1moxEgDxmXFEUMEPAK7I6WNbxahA6NAHd3W3lVNorr1qPeKE03gWlXWydXBbpy2ZZoQFLLm4tVo+FJkXrWQsd0SiB/SEgYloWrFjweOzgjHF7Z9htlzTdP5tFQibiAjTtGoh/MPh02VW7GFg6DjdGT53ODeqke+lV5QYOqkGVLldqF7PilFZMAJkxbv/LPe7iaqLdHaEQ5w7kXSiS9OF80o4jhb595mSNLYUYO3l3YbKh67R3Ol4Ju22vDAkyrJ9TABRNnF53jnVvqh8IzKGqnDgxQ6FiC9MNGNtOw4YGx0r9aVliGa6GSnFb4s0vjWOLQf9LQXcFZeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRsnwstRj4A1U1HIgpZ8esOhhNSbIgdC1OZ9dGvfujA=;
 b=gT6+oQig83AecnSkw3umKzxgVMZnTAckZPZPZF7rHkr8SiEvI6ig6yRqFY4Yq69Gw6tkKdZ6hUeJifEH3LP0JE3pVthffYhLOfwHMRcKGmW0AwG8SoVmKDnZIFI6g8HpcXD6zITqquK8PA7Y8YPXeNFdIV4t0ixmvusESXAWYZpBTehCNvP2Q3QHm1Bnz9hECe0H+xJhnjTga9lPukmAvl6Yr8KMdUz0v0BTDievjBi6gLz5LUO87FhBUQUG4upBpHt9gEaUFGRkr3xEOdiJDgiyLjUaFwthKdbHerhtLy4luCltKbXPJ8M6vvv0uJ7iDeZoCdTSj6rD/eY2O6qAvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRsnwstRj4A1U1HIgpZ8esOhhNSbIgdC1OZ9dGvfujA=;
 b=0RIDmz5RBDCNd2jrPJsA0Bi2U1mxwO1pULI2SNJJFEmRo4sYLqJnaeaew4TTKN/zBekZUU3GYqv7kmHkzxUuWPlc41jWZJS9pt2TTTJSVb1Kl+yL2aq/7Nd7Pej5dWXZ0gdYBCdr22AYjR4gtN2KDDqJwoCT8ILHMdxAVKmaoeU=
Received: from DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) by
 DM8PR12MB5493.namprd12.prod.outlook.com (2603:10b6:8:3d::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.26; Thu, 20 May 2021 22:58:16 +0000
Received: from DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::11d6:3d89:42b8:5423]) by DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::11d6:3d89:42b8:5423%7]) with mapi id 15.20.4129.035; Thu, 20 May 2021
 22:58:15 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "R, Bindu" <Bindu.R@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: Allow bandwidth validation for 0 streams.
Thread-Topic: [PATCH] drm/amd/display: Allow bandwidth validation for 0
 streams.
Thread-Index: AQHXTbvHL5rDxN6hnk+mgVp6ZwAksars+x8A
Date: Thu, 20 May 2021 22:58:15 +0000
Message-ID: <DM8PR12MB5413B3ED8C0407162C8C9D81892A9@DM8PR12MB5413.namprd12.prod.outlook.com>
References: <20210520210429.2467700-1-bindu.r@amd.com>
In-Reply-To: <20210520210429.2467700-1-bindu.r@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=e27fb5bb-a896-41d8-84d6-0b7d0aaeeb25;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-05-20T22:56:35Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97c73cde-6f6c-45b1-c530-08d91be2c0b9
x-ms-traffictypediagnostic: DM8PR12MB5493:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR12MB549360856F372B476B7EDC0D892A9@DM8PR12MB5493.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0zgDgdJzDGEfCkDW63SwMEDhOSsRHnhIv6lpJhoMYskjwlTVrtusbIPubB0t7C9O8kvLRQ66kkNswmO1vauecfbHFU/K+e9rTB0+bJnCbYCPAfKFUrXqr7REy3sAVt9uoYLeRgp0mp4vrjMvFumCMrGcEJ9qqDMfdOXqQaTvjF3iNu33xr1K0wWQjmz1iIXnIsHpI3OUsjAanyfBbfL1wDwKY4/YdSnRN4uNw2983EIxuomdnpAXUI9+oG0pN6NwettFVMiwIqG5IT5+ix564PLokgvHMg0XwdO8w4Y20wDLEftS1vte/4mOrd+msn17kLAUks0v5ZjBh6jfxIyHxyS2eXiGIexrbmhAV+SGSj1sXKVY8UFW3g39/lL64zgn24JawK7Ksq6wuSGOOIsq3MDcZSoDTcvmkzlfPx0jD6YAZ0ANbq/ep8MmcCBrH7oQwrgBKFmih+xS0YEFdskeEw+REHjcQLSimMwOt6FHYWWT+RcjCNWUEnHQ4czH47hhh/F8QtSRbnoQmEnhwxErxhLWRA4Y+S/ANQkJ52T+MXP+dfLe0nJAeFdIkTPT9DenmhcPOdvkz7ESzFXoEuVC5KGa2ZaADl3iVNsfmDDv18M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(4326008)(86362001)(122000001)(5660300002)(8936002)(38100700002)(9686003)(52536014)(110136005)(83380400001)(2906002)(76116006)(478600001)(55016002)(66946007)(66446008)(64756008)(66556008)(66476007)(26005)(186003)(316002)(53546011)(8676002)(6506007)(33656002)(7696005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?XIwcwBdDZl7ibRkedxtRxysGE2DcRCl9iBNOsxlQudC01WP4LzODwvPDevOw?=
 =?us-ascii?Q?s+Nz6RYukDOrXpvkaVyJRnWpN6L0js5Dw0WOSBNQ8wCMLrJtGar1yCN9fExw?=
 =?us-ascii?Q?g762PEJV9ytAXKLpWzdQHa05MjXzzoFleMNMdk53Qfuh+VNhMojlr8hi1Ckt?=
 =?us-ascii?Q?QbrlKo0Q8sFsFbd5+TtlibMOTlUbkl4cuMobaiqjz5F0Bx68P7jApXc9TvB5?=
 =?us-ascii?Q?mLS6rkGN9si5kMztILqJxLnBcwCLQTPX/1mOOvYgyN/cm5AXz6HtzJMZK+/V?=
 =?us-ascii?Q?g29ZEHVDtGclasa2jdKo6+Muu9ULQHEYb9s64oPMZKui1ZJFDAVtclSJ6osX?=
 =?us-ascii?Q?6JOc5YoLjRm7txsn3HBlOwr7jOS8p6GI1/9ni+zAdHmOXNb0lXL3VYu5a6PZ?=
 =?us-ascii?Q?rp0n7YRXVXjgqigsp961Xn4DzKlvQnI7Mm3aBv8mHolyRzdXtJD3MNswBXJg?=
 =?us-ascii?Q?zMkUQ2imcUpeOcE6rnk9Um51FFLm64FG4NJ5rW3QbK4T/rXbHKrhLqTp8f+6?=
 =?us-ascii?Q?kB3GYieuUVcT6U1oO6APOiIg0KpXBVQUzOLNeAcyhqkQ4s9mTQhwtObFXq9d?=
 =?us-ascii?Q?gHJQERv931A0Vi1BzpRMzXf6L0RNdItNqDAcJNknrmbJf00Tz4rxwTgjTxQN?=
 =?us-ascii?Q?0CBIJs4dEXWksSavVduBn/Hm/rTYPgHT0Tyg470CxFOr7JkxdGeLun1BNVyK?=
 =?us-ascii?Q?PYPhTKUqsWVJE0/N9rNdQ4p2cFaI2Em14YPmkxtLeD0iC8VLUKxoSy1t229g?=
 =?us-ascii?Q?4lh9+W+8eJ+FDC5uFgjF0CC8EZ6psDTlHS+h6RVAEpWrqG3JHn+BHOU6vfUU?=
 =?us-ascii?Q?Qz2IqOTv/P4bQs6iIPHllZ7M33aLhD+y3Vp4Ej2zgjyviwQivxkR8eNwMg0u?=
 =?us-ascii?Q?cIwwTwQVXuLCBdLCGvIwDiQZnN/owchN3vLZnRXndiAhGZE8duE9jUVor7s9?=
 =?us-ascii?Q?7Wdaw/ISpAMyA359yjtXFmIBZvX9MgLig/ZE8MZPenKo5jgZDUz7vQOsHgvt?=
 =?us-ascii?Q?5pKxBeakrgFxD9WuZUHDqA3i4TJw/VDxsfAqYQHkglchZC/5Z0vCvreT/l3w?=
 =?us-ascii?Q?caejJEAokc2EDgDYPXt2gprX+jShOBeoF2Z1za3imXsW0L46YdLc9m+hospa?=
 =?us-ascii?Q?2LFf/1Nxrga4QdPs64WqUKILmwGbeS81HTCl06B9UNIiw9Z0DUaqS9LPQfPa?=
 =?us-ascii?Q?J5wukNCIDj/yFUmJqzXFmFyc2zMTRccXKZurtP+tNdh2VjnaL/3jsfopH1kA?=
 =?us-ascii?Q?V5KrGiNt8Xx+3HajLMaWoCgOFplhsOXodE+NRPNjUyo7pKgXbf7yOvNM18ur?=
 =?us-ascii?Q?TnNJAruwqlg7lGHHCfvwbxcG?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c73cde-6f6c-45b1-c530-08d91be2c0b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2021 22:58:15.8340 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VORoxOBh4ODdSbysB9axIYCS3icoqrkrJZIwM3xscES4KOAp7IPVQ4PQ68BgMOYz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5493
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
Cc: "R, Bindu" <Bindu.R@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Roman Li <Roman.Li@amd.com>

-----Original Message-----
From: Bindu Ramamurthy <bindu.r@amd.com>
Sent: Thursday, May 20, 2021 5:04 PM
To: amd-gfx@lists.freedesktop.org
Cc: Li, Roman <Roman.Li@amd.com>; R, Bindu <Bindu.R@amd.com>
Subject: [PATCH] drm/amd/display: Allow bandwidth validation for 0 streams.

    [Why]
    Bandwidth calculations are triggered for non zero streams, and
    in case of 0 streams these calculations were skipped with
    pstate status not being updated.

    [How]
    As the pstate status is applicable for non zero streams, check
    added for allowing 0 streams inline with dcn internal bandwidth
    validations.

Signed-off-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 6a56a03cfba3..0b49420e7d64 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3236,7 +3236,7 @@ static noinline bool dcn20_validate_bandwidth_fp(struct dc *dc,
        voltage_supported = dcn20_validate_bandwidth_internal(dc, context, false);
        dummy_pstate_supported = context->bw_ctx.bw.dcn.clk.p_state_change_support;

-       if (voltage_supported && dummy_pstate_supported) {
+       if (voltage_supported && (dummy_pstate_supported || !(context->stream_count))) {
                context->bw_ctx.bw.dcn.clk.p_state_change_support = false;
                goto restore_dml_state;
        }
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
