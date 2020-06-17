Return-Path: <SRS0=VPxi=76=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8CBC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 20:26:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D0BB214DB
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 20:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="d9/Menzk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D0BB214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E38466E17D;
	Wed, 17 Jun 2020 20:26:56 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CCAC6E17D
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2020 20:26:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFdxEc10WXpMgFkxQtdXkWh+Q4Mf2trFJq/Umx69kDLa/jalAUo7P/CWP3GsvLv2cFsSoJ+wWAK7BHy4PlhDRvvD9DTGPTJEcuPmiaNHKYUFfwadoO4cgHUOP0DTjazXDO3HQ1+4FyvBWPIug6Nr21PG7+9Yq2qPs5CgAgZsRJCe+0MSlSVRYwhJFpgbpCyMVJvKg/NyBGrEk9jkZZEC9r/G4EeIKv5MH+/bPEob+0hX9PghpsdFacmU0vtXHgRu3WcrA3GLzSTQglMdT0oN3BB4ktVUchu5twt+rDPBFM7OdBJ8hNwoVWs68FqJ9g9yf7RuqxkzhbT1KBlIzPc/LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3GIYvu52lK0lggzEpKWSn0VcmeS92lt0i7nVZlb0c4=;
 b=hjeTn4XOD/C1QEieWJ0qpXsNkAVtKeOU0rwSTbKMDc8EsqiwX57jYkNyiPnireERSaQe2Ljuxape4rYTzBBIdRw/HBqK/yqGXHAad8dfxor92khS/7gt0MFgIAFBB5wfVtUFThqtiwX46yCdGXbBCNsTcEz7uuzWHLR5bdaMuwi20bNwYpG22yEuJolw7JeMioRgyCeGVQdupxA6HRrRv6P6O1yQKomrWqkS/ftuQauvJaeNmd0Vzey0Zt65hxQduzTxs0/K/4TAl35gVOgVhyH86bJvn4LXPDzyxe7UWZaGh7N/SWCm70soODMuBRsl02Q46VSu6eeRl0Vcfb/EDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3GIYvu52lK0lggzEpKWSn0VcmeS92lt0i7nVZlb0c4=;
 b=d9/Menzk0aaek9YYAUcGKamGvMX62hwAsi/lP55oqcihBu396qLFAnd/Ejaq4eDkKAD9z++GQzYN9+wz70oAGSTQqpaO6SccGbSinp3oKB9B+Jfk9I+V33GW7SHspE8mpNI/staxcyQL5KM1REMP3qV5q3xebtXtNHKJXvFDeu4=
Received: from BN6PR12MB1155.namprd12.prod.outlook.com (2603:10b6:404:1b::17)
 by BN8PR12MB3026.namprd12.prod.outlook.com (2603:10b6:408:41::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 17 Jun
 2020 20:26:53 +0000
Received: from BN6PR12MB1155.namprd12.prod.outlook.com
 ([fe80::6c17:115:fa26:adf2]) by BN6PR12MB1155.namprd12.prod.outlook.com
 ([fe80::6c17:115:fa26:adf2%12]) with mapi id 15.20.3109.021; Wed, 17 Jun 2020
 20:26:52 +0000
From: "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] drm/amdkfd: fix ref count leak when
 pm_runtime_get_sync fails
Thread-Topic: [PATCH 4/4] drm/amdkfd: fix ref count leak when
 pm_runtime_get_sync fails
Thread-Index: AQHWRNnbiioKuhCsT0KOn4EzE65C06jdPrMAgAACpuA=
Date: Wed, 17 Jun 2020 20:26:52 +0000
Message-ID: <BN6PR12MB1155F8B21B98948FD107F747FE9A0@BN6PR12MB1155.namprd12.prod.outlook.com>
References: <20200617190212.3519907-1-alexander.deucher@amd.com>
 <20200617190212.3519907-4-alexander.deucher@amd.com>
 <68e00259-d3dc-2ed8-cb66-faee4cb17716@amd.com>
In-Reply-To: <68e00259-d3dc-2ed8-cb66-faee4cb17716@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-17T20:26:21Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=83f528e6-062d-47ff-8837-000049737c48;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-06-17T20:26:21Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 3ace066c-69fc-44ea-8370-0000c72932e2
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [38.121.83.65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bf8c5fcc-769e-4121-a865-08d812fcc59e
x-ms-traffictypediagnostic: BN8PR12MB3026:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR12MB30263C19A5D76E859E0A880AFE9A0@BN8PR12MB3026.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k5NwJB3bVw4vWiniN84TVKkJx7P/1IhYcbBA5L6Ky08+mV784lSTo5HfxgNXZEndrfDOU/HIivpLfMXSAItrYUcZDQ64I5dpUUtU5SrYzBY0z09geykdStEMN5rAI2jl22XXWsIQOzcokbKHRZQM7LL5ZLvNR1k+0OYt2AMj7f+WZn39rxJXvx3ApIibkeTtGYON17lbSoPZhPi1gOtpOB+uS6uEWNyMEUJTgLnleCBGBybW9iFq74y34hKa0XOoiAPDi8kgVEOPTFi0TNIYpwO7O90kKJKa2AEh+/P9KiK/CY3fKPk4Ite5i1vpd7/h2T0fLsSaJFjD4a2C+sJafQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1155.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(52536014)(83380400001)(53546011)(478600001)(8676002)(71200400001)(6506007)(8936002)(86362001)(7696005)(55016002)(186003)(2906002)(26005)(4326008)(316002)(76116006)(9686003)(33656002)(64756008)(66946007)(66556008)(66446008)(110136005)(5660300002)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: xIRWEeYZCWKVFPjUroFkcdrJEGWf0i4DoxnmaK6fjXdw1it8OqIiLv2Q1QbCx2F+CR0l31T9i8bHqG/P7i9Wb/vXe69bwg2prbdyWAODezUvesJ9p+wdOYvEhRUdl2q5/rN19VHuKVodkrTS+hy2PcdEjR0koNrQDQuLzGz5s40N1W6KHIlor4hUxDwBY/MfxP5fbj793O6j3bSM7EM8hgtEuc4w/O1UaSodlTTTZPi5uZbdqyqsKD9SCuIG2iLeqYVs/l8QX9EsvyGlFRFpQUBcCA5joQkDjpnQkRs0Ho5Tys9PmltTV17XZqcM2hefFlks7S+kUV+2dAAo7woV0Sq0LYMNxjuKBBuOX676UIcv8Tx+aLK+tc69Zxno++4N/nOOWNlfCuydUJawK0odZ0NVhgc1F8YTgudRsX/A4xOlqAYdj+YItSGaVtL9evqAKi8FfT+FZzB/1pPa0VhyCqYmQn0/fYhgXl+Umoz6v+Y=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8c5fcc-769e-4121-a865-08d812fcc59e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 20:26:52.7773 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sDMkk2KgaE3IAPoMaToKG21CuD16PTWiC5pQpjgBWToXl3m7DHFLw3cCVT/yu4qOD3x0lGrDxHT0unt8Hc3atQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3026
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

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

-----Original Message-----
From: Kuehling, Felix <Felix.Kuehling@amd.com> 
Sent: Wednesday, June 17, 2020 4:17 PM
To: Alex Deucher <alexdeucher@gmail.com>; amd-gfx@lists.freedesktop.org; Bhardwaj, Rajneesh <Rajneesh.Bhardwaj@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 4/4] drm/amdkfd: fix ref count leak when pm_runtime_get_sync fails

[+Rajneesh]

Am 2020-06-17 um 3:02 p.m. schrieb Alex Deucher:
> The call to pm_runtime_get_sync increments the counter even in case of 
> failure, leading to incorrect ref count.
> In case of failure, decrement the ref count before returning.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index a9a7f5aa2710..0b4f40905f55 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1116,8 +1116,10 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_dev *dev,
>  	 */
>  	if (!pdd->runtime_inuse) {
>  		err = pm_runtime_get_sync(dev->ddev->dev);
> -		if (err < 0)
> +		if (err < 0) {
> +			pm_runtime_put_autosuspend(dev->ddev->dev);
>  			return ERR_PTR(err);
> +		}
>  	}
>  
>  	err = kfd_iommu_bind_process_to_device(pdd);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
