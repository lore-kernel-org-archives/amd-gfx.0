Return-Path: <SRS0=V/Q8=BI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2A2C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 02:26:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E608D2070B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 02:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TjXehiJE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E608D2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DAA76E431;
	Wed, 29 Jul 2020 02:26:02 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690048.outbound.protection.outlook.com [40.107.69.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D5766E430
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 02:26:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKcpNsifPiCa0fz0n067YwlnO/DsB3dpdqtLxqB3aflvcuMXhWjX+GRvYtbfAA4gZcifDxcJKe+xGS+uh1r1E3fkEi5O1fviRuE+lkg+EPaZnVmKJq+3wBpn902BjlEosUbF0GVaYfCwYm86V++Y3ut/zClY9lT4SBAu7s1WH0zXIyQWW37aDyr6TE9beghhTQkK4HJpagCMl21qJRHa8SwWsivzONSND5k72RFqXywA+FMxqWN6VO/weaDnpJsRnRGS2D6w0ctYflLSP4ndOp57XC4ZnU4ijqvpa626T7hGley7gsy5YBg13KbFYqjg9AsSl3lLJSqCIVFs6QOGIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fkhg7YlfBCJg4uZwpwAJWwrQFLcuassB8qIqxKoChOk=;
 b=LsiDwczRPo+O5JbZSxIuNOJR4U9WscLzD9K1umWXlckyqisioBXZVR8fvRPTugbV30NjWfTYmELzvjQo35HlMQL+v2kblCkpjDYViHVRV78eEVImdKazFb1Sed7DVd5wID6mb3XYaa9D/dRxWoKj2xGRRMRMVNjWl5myd3dHOGdlquqkTeKAgPb7xvWC4Ved5ErnSmcTXwrTvyRpbcQO+Xs8qvMw0gg0bCiPgNZn+E/dsdTI41V37dt/R//FqLnw9FUjsG4V+Xs3LmADq1PjblAq2Sf1hOqwURXzcsXWbvfJAXfOE1lS5Ua3i2q1RXzAN2v9vpwJLN6y3Pf7iEYjHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fkhg7YlfBCJg4uZwpwAJWwrQFLcuassB8qIqxKoChOk=;
 b=TjXehiJE2vrYrN/PkBB8b6+o2mAnLU3P8EcassgvPLUlc+BUI5atokTspFe/nnRQGAGXNjgDWDtID5/yor2Z6iNpl8+f0aq+kWyqUVlb9DZcgI78xghyENRAOPlIs3j0KtJDV0fHqZTvI28VRBI+d/RO/+oDqQTjio/VNgcoi9c=
Received: from BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 by BYAPR12MB2934.namprd12.prod.outlook.com (2603:10b6:a03:13b::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Wed, 29 Jul
 2020 02:25:59 +0000
Received: from BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::f8df:794c:7431:2440]) by BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::f8df:794c:7431:2440%7]) with mapi id 15.20.3216.028; Wed, 29 Jul 2020
 02:25:59 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: update driver if version for
 navy_flounder
Thread-Topic: [PATCH] drm/amd/powerplay: update driver if version for
 navy_flounder
Thread-Index: AQHWZNE8gktyuoZfAUCZvz/8ITGpn6kd1YSg
Date: Wed, 29 Jul 2020 02:25:58 +0000
Message-ID: <BYAPR12MB2888949EDFE89D391EBFFFDFB0700@BYAPR12MB2888.namprd12.prod.outlook.com>
References: <20200728112113.1883-1-Jiansong.Chen@amd.com>
In-Reply-To: <20200728112113.1883-1-Jiansong.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=35759607-fd76-4713-a54c-00003cb54c7c;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-29T02:25:51Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 495b0b63-37ab-42da-af64-08d83366bb24
x-ms-traffictypediagnostic: BYAPR12MB2934:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2934905FC36BE6729529CB21B0700@BYAPR12MB2934.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +E6qmaGoNB50pQqy1x7pW0HvvZ48r2uGtAlLzFlmhaowfYnRKlnDsDIzTCWPmGuFUR/kZofvMWBpAZLlEtz602DytrY6q110pzdOaf1Rhq9owRKYakGr5Sdp2QKrKxfXt/4/+qgIMAuUbpZFiwHsKCDH81OkX7blOmm2iz1xO9JCW0hA3bCOZVMqGv983u8z5s0pCWsMcKAe2KVayMFE28BvPmSw9ilJWll2GoVOup0uG1iA5YCKKadZnhmCPuIrbY9TnscpmQH/B2TFJdG/7IrI/4L/rGrEwtBDg5HHoxq2Zg79scIeoassWwR1Ks5pFUsl7CWcKJDYSHobXrQpUw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2888.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(52536014)(8936002)(66946007)(8676002)(76116006)(66446008)(66556008)(5660300002)(2906002)(33656002)(110136005)(54906003)(64756008)(7696005)(66476007)(478600001)(4326008)(186003)(53546011)(26005)(71200400001)(6506007)(316002)(9686003)(83380400001)(86362001)(15650500001)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Z3JpLZqEhlhv/fPuvw0VhueFeHw0DGl5q9cV5GG1BNa2MxBu5eEUFeQXezGlMfn/dOvG2DodPpySpmvMMd+9KMKhj1Wc3GOQFrjrBotv2jA6d8siSJF7bFEVxoivSjUZ0yYy31TzvpbOYK40s7CIwoGpeeH/sLIvKJb4phPyIaRF4un650xmdxJtaDsbXM1EhM5OjOcjPGKbI3NtJpvsZPCoBHdzxx5UAqJDnHumv7+LsRWQcV+FIbx9KG9fUrkvA1doXx8glL4bYFHlivGP1Y4Gi3HYeSL2SzY6MOU2pW2gBGw2iPulc7N5haWD1zSoyBeuoco3cn5ZK+g4Lf4gVnfDOuL3DIjVaruFow8ofE2aF5/EWaCIXLQDbFHFd1UqDZ57WY4RGtMxhIk03aSl0NrRisLAPY7cZAHKaCBnDAsIMjTAKLyioOs2Q4S7QVpcsuHCYGjPSWuPg6gpWcf1zce8EuXN7UE5hkBhZBBq993732+jR4polEYDAOhw87rT
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2888.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 495b0b63-37ab-42da-af64-08d83366bb24
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2020 02:25:59.0660 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4o67pO0gEa7gcpln7Fb8BwyiMjw2V9utKqatZZnxcJFXBNCcoOwbH5/gIlRFQZ9h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2934
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Chen,
 Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Jiansong Chen <Jiansong.Chen@amd.com>
> Sent: Tuesday, July 28, 2020 7:21 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Feng, Kenneth
> <Kenneth.Feng@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
> Subject: [PATCH] drm/amd/powerplay: update driver if version for
> navy_flounder
>
> It's in accordance with pmfw 65.5.0 for navy_flounder.
>
> Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
> Change-Id: I984a1147030264adbc02230e2e1dd416d4ad63b0
> ---
>  drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> index 9504f9954fd3..6a42331aba8a 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> @@ -31,7 +31,7 @@
>  #define SMU11_DRIVER_IF_VERSION_NV12 0x33  #define
> SMU11_DRIVER_IF_VERSION_NV14 0x36  #define
> SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x34 -#define
> SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x2
> +#define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x3
>
>  /* MP Apertures */
>  #define MP0_Public0x03800000
> --
> 2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
