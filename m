Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B20C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 06:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47C0310F274;
	Tue, 10 May 2022 06:36:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9589D10F274
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 06:36:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHqIex0QDngvw/jfo+Tnq1afXmdqYk2B2Fi5oaGtVSlc1VvJj0R7JsOPCc/bMMzZ4zIgoL8R8SM3CHkmGfD4VkM0HPa55SJXLsXyf/7BEs5NWeBce90CeWKj48oIG/9MCL3i7FW3NwOwWqEo2vlOP0hXdHrbnasYiyL4O+xhoKyzL5Ng1V34p//cUVMDp5uC5r3WYGkE/quga9kK7TYkLgRQx3BgYOh/uKikrh0h5l4uYmE4J9SU/E5BqS+D55UqFdV9apfTUvN7T8ZrK9slLFnMoLddCsbsmVue8BCaaKS9iHa2Y/nGrJt791Vy6bWwQq3FiDjFyBxB3yZj7m6f4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qoGx2yGhkqM8qFtYdoCLja/qgYrA3emR+cXeD7cLaYI=;
 b=G45Pp9JqdPeBisY6iKJtK8LeyyHRnZZxmh6DwKPw1N2e8Mqj78Ou+4YBRr7lCa99RnXUnbADxJwndFLXCEFk/EiLbOrB5Up0j4a2TZOGnmXCKHdH1/JfCvO46Mf1/MVMBqfClFXCuKQh6fNDldNjdaLUGhp7tIgaVd0+U7nHh9NBkolfMiUn4n07XC3xKxzSzBxxcj3JQH9YQW0tUOm/7UpiOahKyV4RWRiNS9kVywXsM4WLiWI7slEvgFrlwZTg2LItxvn51Z8fY7Y1xGWcdYhawvnHonoy89vdGED3+XW0N0K6rleNpspyakTm3pCon2jZ0buCiiLLhaNWejuQhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qoGx2yGhkqM8qFtYdoCLja/qgYrA3emR+cXeD7cLaYI=;
 b=1fgAXiIaEPWV9y4L0b8yKtmaOy+3dl6ItlP4jzAx55LqXR+57ylLHoa0F7525UbhypRqpVSGeQjlgEyAQWjLTGKW3o0V4JKzX8F+qESb3IiEcq4lQ+Pd6+Xu5LQFQSPL8XLmkObeLFMYqXCL8AG4+XKAx2QhIfaT83+XcSvjsVo=
Received: from PH0PR12MB5451.namprd12.prod.outlook.com (2603:10b6:510:ee::20)
 by SA0PR12MB4543.namprd12.prod.outlook.com (2603:10b6:806:9d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 06:36:50 +0000
Received: from PH0PR12MB5451.namprd12.prod.outlook.com
 ([fe80::7592:912e:a3b4:296e]) by PH0PR12MB5451.namprd12.prod.outlook.com
 ([fe80::7592:912e:a3b4:296e%4]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 06:36:50 +0000
From: "Ziya, Mohammad zafar" <Mohammadzafar.Ziya@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: enable RAS IH for poison consumption
Thread-Topic: [PATCH 1/2] drm/amdgpu: enable RAS IH for poison consumption
Thread-Index: AQHYZDdmkUWGmHw26EyPqnyZXS0Ub60XqAJQ
Date: Tue, 10 May 2022 06:36:50 +0000
Message-ID: <PH0PR12MB5451C829261FDE07A5CDB6E398C99@PH0PR12MB5451.namprd12.prod.outlook.com>
References: <20220510062950.11792-1-tao.zhou1@amd.com>
In-Reply-To: <20220510062950.11792-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-10T06:36:47Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=bf5faae5-af0a-4c6b-8e7a-7ff671c607bc;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-05-10T06:36:47Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 1ab1e09b-44a8-482c-b2c6-d9adae83eb14
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12e490b5-3055-43e4-268d-08da324f76b5
x-ms-traffictypediagnostic: SA0PR12MB4543:EE_
x-microsoft-antispam-prvs: <SA0PR12MB454393F23FD85EB0E2B1DF6C98C99@SA0PR12MB4543.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: osvJEH9/ebCPXgg5yeVFtBopn9CK+o9YDxSnPx0jrOf23KxRVQIV+UXU26yYElR6K+0A63Lj3DAsIpAQ7n+6k0c/3koTjQbin+yJdA/2tfZDSRnJDstVkokOCUpre+6W4Zu4y6FPhGg4JJVh52rQsHEO6NQxGBODLd9Y7sLv+CAlbTVQr/GKbjaRXsnR/4gEQUv//madhJVTKsqtoG6qNhsDnMtK/DOAW6lf2QW9pIO/w6RCoPVL5A482oQre8U61XtpH+Q5QROU78BxBcNQ9pm7zkWtw/7K9tg5Zs0MTz5l89+37fbKAYowmJ39FpKjo4MjQ0d6tFG9mXmTSB/OFR/fP4T7nn08D/lpC0ydq+tx8J3KHgLRGc8x1NNtns42Idd/zbEwburw9tjM0u2NLGQK4KEDee/t0T2036j+mP79yLimuTlOx/V/YCnzr6yr1loiysvfspHKj3Tw1RMl6JYdndXfG5xw1Dl3UTGq6bMB1pUP1Xd4kfIPmC02K3Vdi/TKhOctpwo7oyl9Om3+6dUsQQPzEdWZ3noxllOQQxS1Ujrw90AqMZz5fxA6WIsLLBansWMNGDV+jKRHVv7buyuKXzc+xYLfTtGf1YKKcKJX7zppV19LBzK2ZQaD3Icd6t1YevBIYfxFCxIAJ7lMh70hSDvwIv0xe+a8LUGtv/esHii0K+tJxOFlphqFP6tCqb73gZI738V0mxQC9UeSyT6hxTdmMrMGX8Mwn/iTXjY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5451.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(122000001)(52536014)(2906002)(921005)(8936002)(38100700002)(38070700005)(5660300002)(55016003)(508600001)(186003)(83380400001)(33656002)(4326008)(66476007)(64756008)(66556008)(8676002)(66446008)(76116006)(66946007)(316002)(55236004)(110136005)(6506007)(6636002)(7696005)(71200400001)(86362001)(26005)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ClIBAZCvpGHJIEFH5vzTJ0eDBYKSRgRK4Jt6Zq3rYQ0WN/IgB1iqNHjee/A9?=
 =?us-ascii?Q?qPLnZwKrmrCs99SzNAdnh0z+pWjplyuR2pLhgv/CP7N5RBqqwwu7rDmAXEYY?=
 =?us-ascii?Q?x+chSJxw8HZcI45SdlhVz/Tt5VB7KdVPgXpLSrtBagY0qA/QZzWkQesWExWh?=
 =?us-ascii?Q?C4UreAZQNEKZu0DV1DgWookjyYBVSYT0445yUccxAG0n21QWv1B1/p306cku?=
 =?us-ascii?Q?jAHvg12ZjWSn7a0tnUT4ox1/wDLFohaTWB4856TCZIX2wb2Azspl+u0ys5my?=
 =?us-ascii?Q?O5Nv3lbNg7LO5EJIZUc4RxtiYBcJ+qfPko/gNYNmItpS7tmHj83eyyxXRae1?=
 =?us-ascii?Q?T5a7vRYUS95juu22SyQ8ctije3O/pMa2x5CtM+xOtm7nr258RmTVDRdXfRfT?=
 =?us-ascii?Q?fMLsNAV94jWJx+9oUfLQ7FKMLsJG+u9FaXrD7ijNRnGfGzkSp2o5AMUo/qqF?=
 =?us-ascii?Q?J/1JnFW6gbafOQ/zkAnAcQaqhIWTzG2B3o10G6VJ39bPtQlIYt1BmkmSDma/?=
 =?us-ascii?Q?5FkhSFEFSVU+xityjtuPHzbQd0k05A06AN5+fWKWHEML6LBG3O6AKPHvhANu?=
 =?us-ascii?Q?3AL761d/Yya9gx7m2c4+0100cyqpePHcFDZl+Paww9rKuvgvFdX6g3Y5WD6F?=
 =?us-ascii?Q?CmoFL09yScu8G5tuHAgBjBbrkbG94b/8imYiXRqzpkY456xgdSClEk+fWAmC?=
 =?us-ascii?Q?v46bKHfSoGU7bT5t8OtPpi9zn7J3u0Asem/l9LZfmexjCh73oC8Dcp1ER/6X?=
 =?us-ascii?Q?4o5smVWErCaVo4A8rUSXrS4LgEn7GpyDlLbe6J00fJvF5ngzf0VzZoft/1fV?=
 =?us-ascii?Q?9XCYyji0DMd+LtjiSUd237G0uAZ3Mhy/WoY9K10SFnFFGtKXMbMYBmGz+UE7?=
 =?us-ascii?Q?iHCRb3wMMluw2uerTriGqOM42Q4j0G3ti9LADyvnI0Lv7WftHto6u9aoLB38?=
 =?us-ascii?Q?QzQ88imUg1UOCGJsvwN1GvtaDOUTcxJhQ73A5bkrlGeaB6U9RuHZsW/kD0Zf?=
 =?us-ascii?Q?GOdroUou+KnAsiw2xwaR/4eSPKGtxfE0oJhAQQUM2Ax4H236+zyEBHPzOoOz?=
 =?us-ascii?Q?+VHBvntSpsoB7Ee9zhrrhXyoPmjfToRQIRDJn4jf/kRhpuw3qBCan+PXKLvj?=
 =?us-ascii?Q?I/s1xfaQppefsDc5CxSljGEeaZm9F+QfWnsBa3GN6aokAUYVm4jIOEaDCzQ9?=
 =?us-ascii?Q?B3Y6Qf1evE+psKQ2GTMnTPThUDvrullVwWtoh7r+iiHB6iDqA6iJXDOT1n0t?=
 =?us-ascii?Q?lkSzwsY8PLqznrj7jCcRl2GrBJhwqDcRnuAxYR/WchmqcC1M2xi0ufV0WaNE?=
 =?us-ascii?Q?j0v+EvkcNJbaDV/tESTwnva5mn68ZWaQpaVQm3wJPilyVamkzF4sjy52vHRn?=
 =?us-ascii?Q?1tKxwfl1jZtkgj//I4H4Pxd42+IYKWNkXWZpBcZsk5i9NKoRFFbaZGtDOLzH?=
 =?us-ascii?Q?F406+EFrQzLJqbK7aqC2Hs7laBhdRVNGa24ZYecHuYRPNvpXK4TQFlKrbt6E?=
 =?us-ascii?Q?kOEBL8JI3lBUGHJgg6nrwrutbEYQwJBoLUhO5ncjUfNO/oED7PMBcCY83S2R?=
 =?us-ascii?Q?yuc5vhruGIoxZ4XeTXeqqzRr/j4OxJwfthMNX26xH57/6JOmgIuXia6EbO8O?=
 =?us-ascii?Q?fz3A1GYC68LfZhBTCLtxe1CMg853OnvmX0TI9qUHjbJ7tLUNJACHq53PP+Sy?=
 =?us-ascii?Q?GfQuOQyq7svEAZLgwN1ZsBLcHut7MR2uEG9TR5IJcmzqA7y4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5451.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e490b5-3055-43e4-268d-08da324f76b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 06:36:50.1266 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: comg84OiCSo09uT54c2DTbE6vucnA7A4LGrrtiFvoImTtqLCKS8+eGjhoklPua+G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4543
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]


Reviewed-by: Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao
>Zhou
>Sent: Tuesday, May 10, 2022 12:00 PM
>To: amd-gfx@lists.freedesktop.org; Ziya, Mohammad zafar
><Mohammadzafar.Ziya@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>;
>Zhang, Hawking <Hawking.Zhang@amd.com>; Yang, Stanley
><Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
>Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
>Subject: [PATCH 1/2] drm/amdgpu: enable RAS IH for poison consumption
>
>Enable RAS IH if poison consumption handler is implemented.
>
>Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>index cac56f830aed..91d9e9969b4e 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>@@ -2516,7 +2516,9 @@ int amdgpu_ras_block_late_init(struct
>amdgpu_device *adev,
> 		return 0;
>
> 	ras_obj =3D container_of(ras_block, struct amdgpu_ras_block_object,
>ras_comm);
>-	if (ras_obj->ras_cb) {
>+	if (ras_obj->ras_cb || (ras_obj->hw_ops &&
>+	    (ras_obj->hw_ops->query_poison_status ||
>+	    ras_obj->hw_ops->handle_poison_consumption))) {
> 		r =3D amdgpu_ras_interrupt_add_handler(adev, ras_block);
> 		if (r)
> 			goto cleanup;
>--
>2.35.1
