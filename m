Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CADC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 10:27:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B261B224F9
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 10:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B261B224F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65DD46E1D3;
	Fri, 15 Jan 2021 10:27:04 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1438B6E1D3
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 10:27:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWomDMZLHGt5Tc8zdL8xA/lUzdEbML+tCO6c/9qc0GEodDIU+310VpKtrb578h0wVnTUEoxQ7o2/cw9v5WyAuKEvfY1ZfQA8SpxGjs9gh+CJsE2GU2We25yIzZLH1z8sHU1EFjYinHBuTEeqvLhylzK7sH8WvDkrU7gAcowNTEBm4hU5aCwWAimBhYtEFEivdtMFUAC8mtMcZOQsX/vMj2T+NHtDW6A/AmU3rLfwh7GMOKgwkqXU2F2iYhBSUKLKofxvQttTFO12QowoiXTTYJEa1F1BvMUgTWPVHqxd5DbcW/8VOMjGs9MOv/1jVTx7h2p/0N2XAhjI8HD3O5CTqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQWywZaLHOXNmu9D9r14CtMTgphAV+dfymDc10Rhd14=;
 b=gPfMzhNEQ19nRAX/C7H9maP5U9c/PI9nmE2q0lOSCKPJ2j88yCYlMhKMjD/YYndPy7TZvlWJYSxY/7lM/wdMDan6gr7dpA68kRcjNtduSRkksjg0I0LSUUqRIlIGjQOAYEQ+upt1YcL2mG3oqFbwUq4ZBcgZ1RQaH8oZPI2c3teA7D3rTZIZwPuxJZFJaYFTI0IqJAKn2BsX2wsLVgWaWH1PMF6fCuyMFlCmjeuB6euT0kE8qJV189WbV0cKbeXLH3NkPXaAFgZ+KiICkO5BiB/I0932hSt523lIxlkppGwhqYWCjZfKXHKAFjMkxkYnp9GzNhzOzfBh2wam5eJFwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQWywZaLHOXNmu9D9r14CtMTgphAV+dfymDc10Rhd14=;
 b=yByEMkCLw2YGBjGDErgZIT9QB7BFpxL95qqud8CSzJ40SwI8d/1NoS9uKwZE8eXX932IdfShFyRYKUKyAC0SWmGfavnjk7yQxednfd35kLUoG+WJ2x/oUAcpQkH9UXsXcHR9DhsrVPlUgj1EhFiQdnC+Bo1CCR6eWs592+vaEa4=
Received: from DM6PR12MB4650.namprd12.prod.outlook.com (2603:10b6:5:1fd::27)
 by DM6PR12MB2955.namprd12.prod.outlook.com (2603:10b6:5:181::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Fri, 15 Jan
 2021 10:27:00 +0000
Received: from DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::6034:a5cb:2764:f533]) by DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::6034:a5cb:2764:f533%4]) with mapi id 15.20.3763.012; Fri, 15 Jan 2021
 10:27:00 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: update driver if version for navy_flounder
Thread-Topic: [PATCH] drm/amd/pm: update driver if version for navy_flounder
Thread-Index: AQHW6yCqktSPpitr+UevSklg6Vfczqooe3hw
Date: Fri, 15 Jan 2021 10:27:00 +0000
Message-ID: <DM6PR12MB4650DA3DFAA94AB99195EB09B0A70@DM6PR12MB4650.namprd12.prod.outlook.com>
References: <20210115092722.2589-1-Jiansong.Chen@amd.com>
In-Reply-To: <20210115092722.2589-1-Jiansong.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-15T10:27:01Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=98c8c034-e1d0-4c20-ba27-ca1a3f952472;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1d48773a-a349-4aab-c1e2-08d8b9401818
x-ms-traffictypediagnostic: DM6PR12MB2955:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB295576CD75DEF2F1BD97F635B0A70@DM6PR12MB2955.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qy+6cau9y3eQoVWBhg2nlRtsL7UWDUNmtnIF1AyTebXyM5pLY9hIxS9ZqbKaZPunsXeKhKb4zHuIhG3FSRpkxTWt5M2EVLfOwUiroclx6trWYOL4+loehdX4IZuwRMyj/84NRqLXE1mwCn0DN46x9/Ge42G18b1ibyDvxueRh3pdYV+GoSP4hsXCa4QBD+funeDG+URQtgIEliBz4FGkIMSH6UJQIgv/Ox1TuP2jxLhWWNfngucRukl9tSDuW6nfy9C1iV6eG8Fr83BQNzaIHNe8Dp/JbxKtns7gEW1tC3ZppaEPXXotKxUrkhlitcemQSdsJesi1DhId/b5s142VdQe+91lpBbuv6Bc5N17YTKk4eDZUPFGrxWzYPtwYcXXIVibxjGIYA9/VO1f+cukHw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(52536014)(33656002)(86362001)(110136005)(2906002)(478600001)(5660300002)(7696005)(66946007)(83380400001)(76116006)(66446008)(66476007)(71200400001)(15650500001)(53546011)(8676002)(4326008)(6506007)(186003)(8936002)(66556008)(9686003)(26005)(64756008)(316002)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?WafA8YHhVPD7qUSAHjHWmD2syqldwOAJIy9u8QOyk1p2otBrbdi8CIgV87Ze?=
 =?us-ascii?Q?2/4GqdVs3hGTGWexBTVGeM/JP/qgzfoqp6/jBCKTgIeLACNdsorbiX4mmEkk?=
 =?us-ascii?Q?hfw+qn6AdYUVmHCTqsa4ID7NH8plO5GZ/2d8ZXDptCZGBP+oNfZoV+JA34oH?=
 =?us-ascii?Q?eHx015JpSQlyan7FIbq5Q6uADSs18zwx12YRt6U0EKM/ejkDcXjWmAE7hWSM?=
 =?us-ascii?Q?f1QhPuZaNcYX76QMyn7ZC+uzoHVf8JOnAuvMdWxgLzKibLk+csDhtfEGrTNz?=
 =?us-ascii?Q?i92X/CSlmzz3BPLN5evYu5+FK0FW3JUjkJY53HM/PGRz0jXuJ1d7kRgu95hu?=
 =?us-ascii?Q?2UXK5oJnOAQc3gF9nnHS+1lG3LxMZD1g+a8BQD9a5IivqDBvKdnjourWhEl9?=
 =?us-ascii?Q?x3XsUIU5hXAXPU+YgwUL+loVFdwnt/y7LVlqpmSnaLjZHNF1DegQbWk3agqO?=
 =?us-ascii?Q?LYNNlv2wHNLehtVyVW5JJODbLoyFJWahiSYtalaNyxKal7qBxTpLAm3lScaJ?=
 =?us-ascii?Q?Ss7GPeubIHhKitYsIdjzZjb+LPi7KPsRlpBX69X4LN78225kPRT9rZl1xnuG?=
 =?us-ascii?Q?objoZY4PmEYyGOcSzrRrtXAJtJaGl4zhQ20/EcXLmtje7H8Ckua3fuE5hkKp?=
 =?us-ascii?Q?INz38F6nxC/p/wVDGUWk0A3iv0pl5E/R5Ytat1Kk4YF1ku7fbCYzfAe4eLjv?=
 =?us-ascii?Q?lvl4eCrhDv9/F3Rn+L8UJs4nDk3ywv13cZULybBqsb8jB9yOSkJNuISeL2IJ?=
 =?us-ascii?Q?JDWJzJFy+G1qKfsmsgWMyWcpsBX1v3lQpDWhvYRNGi/D07hnGOwTSnY/FQC5?=
 =?us-ascii?Q?8l603NTInbMrYEzIm1c6cJm5/PTelw7/WKXH+6aRiZiQnwPpqrjaSRGNvHnT?=
 =?us-ascii?Q?4PmSK2d24qtrEdfmuHBVP/6dhW81INzGb5+bSD12Dd7UPNEuxs02XJIqOZt5?=
 =?us-ascii?Q?O3PPVx3SrbfRmEPK1/cEL4v7K+v1TtpIgMbjaNq/osg=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d48773a-a349-4aab-c1e2-08d8b9401818
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2021 10:27:00.5866 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lxmjRfytv2LbOr9Szc5g2HlzUjyQ5OKznA5cCSLXHFFYftC+Qw4x7RVlbDlwu+kX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2955
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
Cc: "Chen, Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Jiansong Chen <Jiansong.Chen@amd.com>
> Sent: Friday, January 15, 2021 5:27 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chen, Jiansong (Simon)
> <Jiansong.Chen@amd.com>
> Subject: [PATCH] drm/amd/pm: update driver if version for navy_flounder
> 
> It's in accordance with pmfw 65.22.0 for navy_flounder.
> 
> Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
> Change-Id: I85fcf7a238b5a7d1da76709ef7963140702048ab
> ---
>  drivers/gpu/drm/amd/pm/inc/smu_v11_0.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> index 13de692a4213..102a0cf12d7a 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> @@ -31,7 +31,7 @@
>  #define SMU11_DRIVER_IF_VERSION_NV12 0x36  #define
> SMU11_DRIVER_IF_VERSION_NV14 0x36  #define
> SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x3D -#define
> SMU11_DRIVER_IF_VERSION_Navy_Flounder 0xC
> +#define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0xE
>  #define SMU11_DRIVER_IF_VERSION_VANGOGH 0x02  #define
> SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0xF
> 
> --
> 2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
