Return-Path: <SRS0=l6GN=4A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A67C2BA83
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 15:19:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74D34206D7
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 15:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fDVHYy3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D34206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A1FD6E077;
	Wed, 12 Feb 2020 15:19:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39A5C6E077
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2020 15:19:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqI6Kkg+W61M68wlgCeW1TORmM6QroDWaksQohmhDw0AlIvigiDEm0A71SQThG4c4ttLngNGW5dz4Q5LUNtuGIGC+0u70njcdoCH76NAiKDCCYXmZ9nU8meEUKx/CdIxOQt5AcGbY7VYF4GB3ZRRezzLCZ07iqBzOc+tWoMftosn/CO/uR0PIo6p2x/8WLeVQLBVUEGpN9zlNL4bGQyDJmRj8uIHEq1ybiOspep7YP63HYH29LrdSOrgH6+5dfB4vuI6AmB7Y5IoKoSFtzxmF/P3GIc5Sy4ePKObmahMuwJHL6a9I/Plw7YOrLXsniuf638zBbrNeToPbevcNeFlfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAmGgwTfz0wmoBP0bsyXSlwGr72xk71BPQakcoadk7c=;
 b=N+pOSNv24EfIZAFqYt/TBDyMIEQJ1fWdtIteCe2/Twndtne9qPWWP0yK9gwNYSJpm3w2cTwZmN3vMczeLHbnVzQ3Q51r4iUlWQIYJwdodGh4lK3p2GgLEw1qByP4S8OqJS//NyS6xO6BkURdczawe7jnz79NJTJ/4Qwt7Y3c0fMlbcC6JMin/6kS4sf8Cn86MpMtprKEnPdtAPBXrt89oiPNy0KsOoT4J6etDqjFdE1t3uniGL77y38DvVWVBBwWMYHJJjNOsIkSATtLZt8BidYMAqU4qile8ep/+EokNFCP8hWAlNUdFonipHDkI8E46mEOBNl0lvM++I2Iu/NU0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAmGgwTfz0wmoBP0bsyXSlwGr72xk71BPQakcoadk7c=;
 b=fDVHYy3eXTPSN0kxe3do5NC5A+jCis/Q7Toe6s+cP/8ZvDSgBU/rW/d7wwCXtoTLmXTMFKmHQDmOqpGddnc6k0u02Bu/E8QLZEbQgH0lRmtyQmO5vHkIOa9Y9yCSB/oY8UuqazeQ3dhiDxJCt6UGXBAXLZI9rlB/Q+UbHdUIiNs=
Received: from DM5PR1201MB2554.namprd12.prod.outlook.com (10.172.92.14) by
 DM5PR1201MB0139.namprd12.prod.outlook.com (10.174.247.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.27; Wed, 12 Feb 2020 15:19:53 +0000
Received: from DM5PR1201MB2554.namprd12.prod.outlook.com
 ([fe80::f4c6:42e8:77bb:d721]) by DM5PR1201MB2554.namprd12.prod.outlook.com
 ([fe80::f4c6:42e8:77bb:d721%6]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 15:19:53 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/3] drm/amdgpu/display: extend DCN guard in
 dal_bios_parser_init_cmd_tbl_helper2
Thread-Topic: [PATCH 1/3] drm/amdgpu/display: extend DCN guard in
 dal_bios_parser_init_cmd_tbl_helper2
Thread-Index: AQHV4V2UWf22QV1hjkaG0ZdeXDX/tqgXrMAg
Date: Wed, 12 Feb 2020 15:19:53 +0000
Message-ID: <DM5PR1201MB25545C104583873E762DA8B89E1B0@DM5PR1201MB2554.namprd12.prod.outlook.com>
References: <20200212043258.1123758-1-alexander.deucher@amd.com>
In-Reply-To: <20200212043258.1123758-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Zhan.Liu@amd.com; 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3e63a604-db05-47d2-7a69-08d7afcf0297
x-ms-traffictypediagnostic: DM5PR1201MB0139:|DM5PR1201MB0139:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0139271A9CC26B4C8FE29D529E1B0@DM5PR1201MB0139.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(199004)(189003)(26005)(5660300002)(186003)(52536014)(53546011)(6506007)(7696005)(110136005)(66946007)(64756008)(66476007)(66446008)(2906002)(55016002)(9686003)(33656002)(76116006)(66556008)(8936002)(498600001)(81156014)(8676002)(81166006)(71200400001)(86362001)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0139;
 H:DM5PR1201MB2554.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dz0XhU5J57OsYDit8CrgKfbKjc5Oo6HjKnPg44hcxhPcnuz62wKezfD4TKLeZEJ5minKy1eWIoAyFraH/gh/QYy2MQYQu0dHXFZ28K5AUlNyOOXYq39Fg/nJH6fPlecDieW4HBSW22IizWT5Mnfca0L/uKBf4oXUL2RhE40U9hFIYnsVmuccFYvOReGEAdWV9IgDllNAPQofa3K2qyBvSsQ5yoEhnHJddRpk9CqMOU3+ZkgUQz/E+4O+S8N5TIwFddkjkrxoI863uiGe53BYaC1EvQ8KoS0iWFMivvBMFkdQfP9qH/O0VlqZg2sbmCFeBSvk/pgsm75pjb0etCDTAMzyXYDRdRwGvOTx8aC4eLmdrUSQ8431OvK3trEOQapOu6LM/TgX3a1dQ3zUjUywuur9Ks9ldw2Dh3NfeNHJ10y9c8cEdLD+icj4xxdG9fM7
x-ms-exchange-antispam-messagedata: FkldD41QyfPEwJe2lXicDJZ9lzXkoLfdB1qhm394rxxYfy7job58Cy+GoYTkJeNbYd1zAaAeJ+znY3/PSaFp1jE33PR4ci5/rIS8QkwACnpetSP1nkND0dXFioUZJ3pc+XY9tPrZtLGFj6CrbH4Niw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e63a604-db05-47d2-7a69-08d7afcf0297
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 15:19:53.1927 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: irncTFnpuXZv9RH8uOmb9IVPmBJrBNCCvnOSVqdRU7RXTEBXIyvMjw0UclCXiQxZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0139
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


> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: 2020/February/11, Tuesday 11:33 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 1/3] drm/amdgpu/display: extend DCN guard in
> dal_bios_parser_init_cmd_tbl_helper2
> 
> To cover DCN 2.x.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

This patch is:
Reviewed-by: Zhan Liu <zhan.liu@amd.com>

> ---
>  .../drm/amd/display/dc/bios/command_table_helper2.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
> b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
> index 7388c987c595..204d7942a6e5 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
> @@ -53,25 +53,18 @@ bool dal_bios_parser_init_cmd_tbl_helper2(
> 
>  	case DCE_VERSION_11_2:
>  	case DCE_VERSION_11_22:
> +	case DCE_VERSION_12_0:
> +	case DCE_VERSION_12_1:
>  		*h = dal_cmd_tbl_helper_dce112_get_table2();
>  		return true;
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
>  	case DCN_VERSION_1_0:
>  	case DCN_VERSION_1_01:
> -		*h = dal_cmd_tbl_helper_dce112_get_table2();
> -		return true;
> -#endif
> -
>  	case DCN_VERSION_2_0:
> -		*h = dal_cmd_tbl_helper_dce112_get_table2();
> -		return true;
>  	case DCN_VERSION_2_1:
>  		*h = dal_cmd_tbl_helper_dce112_get_table2();
>  		return true;
> -	case DCE_VERSION_12_0:
> -	case DCE_VERSION_12_1:
> -		*h = dal_cmd_tbl_helper_dce112_get_table2();
> -		return true;
> +#endif
> 
>  	default:
>  		/* Unsupported DCE */
> --
> 2.24.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
