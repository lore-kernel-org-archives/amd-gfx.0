Return-Path: <SRS0=X6dN=BQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE54C433F8
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2020 11:05:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7888204FD
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2020 11:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1azoKcIv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7888204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 025CD89C80;
	Thu,  6 Aug 2020 08:39:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7E3B6E897
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2020 08:39:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZrW74GVDUwgPz4HMfh4leVDV4I1tQauG8D4p8M1RmsCQz9zG4Gp2cNckgBNYtnxrAkOVQQnDVbEOVzJTat+Ff1SWZC4ForIeSha7uPO+OK4ud03kXAy8MsIQmfFUOQh/hGpGRLYl1pf4ykPMCNojf1SKKjl0C9v8rTWUnzRsV7VHRfjnCbhKSX3rwe2Bh0nWuj+MD3nsUuA0m3CeKQUEVuNVFCb7n8BIu0PyTapI+01KL9lyhyb1GDUmXryb4ZPioDG0Qc4dWckxAxSFlkem4m8zN6pD8w8Ty4RcbNIXIN7I5AUl1YZw5vngRl60L9zUJuQw8gWMd8bADYWKU4PNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJH+/SnuKWltkBo9FC8Xo+ukL5D69y/DymaQ2G+fAM0=;
 b=BPKlvsP/aly1jYjd7oV9tU9Ckp/VDzNqMIeRrCUyGlg2/Be2MCfDLPHQhDGPYqeClACGTR8jDX1DbqhDY+Dz3Tul1oc/Yqil9Tw+vVos9rHj4dqrsQ7EwDp3wmS//iyWs8nJGWCTDDf88mD6briy51sHNisshP1g9unrEnX1qvqchaZsv9UuGZR+Im0PudS2G36W1RhO4JrlTDE6/S0anhsknHNCtNmsYICe+jj5qjiCjuDxv79cQml198zljHdyb7zDQ6UQtVek1IEtpRK/U/Ineny+8Qyyk8r6Vy5qaoBVbRDwiQNeFCqI4Gr81kmb1w92pREgHnn8hoWpEM6kvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJH+/SnuKWltkBo9FC8Xo+ukL5D69y/DymaQ2G+fAM0=;
 b=1azoKcIvsGuFQQ8zeR0wnSDJyblGpnBPldRyxtlGXdbahgRBEtJy+kNLpkTJYCIk6Yz0lP1LN18B/BbuwDjeI4mJ92O577f2YIfStCjvzjFFPdptaiNQNVq+/I/6H5zpGt9E7R1uLuIJrZeCeHp5mjG3e9z6jODBIIcnCSidliE=
Received: from CH2PR12MB3766.namprd12.prod.outlook.com (2603:10b6:610:16::21)
 by CH2PR12MB4232.namprd12.prod.outlook.com (2603:10b6:610:a4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Thu, 6 Aug
 2020 08:39:40 +0000
Received: from CH2PR12MB3766.namprd12.prod.outlook.com
 ([fe80::9117:2aae:1acf:dec6]) by CH2PR12MB3766.namprd12.prod.outlook.com
 ([fe80::9117:2aae:1acf:dec6%7]) with mapi id 15.20.3239.022; Thu, 6 Aug 2020
 08:39:40 +0000
From: "Lin, Wayne" <Wayne.Lin@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>
Subject: RE: [PATCH] drm/amd/mst: clean DP main link status only when unplug
 mst 1st link
Thread-Topic: [PATCH] drm/amd/mst: clean DP main link status only when unplug
 mst 1st link
Thread-Index: AQHWag/YG0jbL61JbUSPgaYPq3WCL6kpnJ0AgAEmi2A=
Date: Thu, 6 Aug 2020 08:39:40 +0000
Message-ID: <CH2PR12MB3766A68DA7760AC75E79972CFC480@CH2PR12MB3766.namprd12.prod.outlook.com>
References: <20200804032927.32274-1-Wayne.Lin@amd.com>
 <20200805145450.ouxbrqlhd6xnrwu7@outlook.office365.com>
In-Reply-To: <20200805145450.ouxbrqlhd6xnrwu7@outlook.office365.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-06T08:29:11Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=d52ce0bb-5821-4e21-bd17-3c67e815f103;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.135.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 264fd0f7-670f-40d5-2287-08d839e442b7
x-ms-traffictypediagnostic: CH2PR12MB4232:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB423256CCEA6D2E0A4D80CD5EFC480@CH2PR12MB4232.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XAOYsYRxZApSYT9sAHb2W90yZlvKqVaXb+KRxwygid7Rcpss166Hbs5fThG32u5esu/xsDmaI3F7bIy+i/QSL56Y/6av6gxFwLoIKnA1QmbQpHcgF1kFwiMYR0M/n6WtRnyHr+zIdjymIXtkqXKOlZCeOkZE5bbfToRQsFY/qWG6Y0H1nEeyO5KH1YNmi5moBoJcQBT3Dw33ivGHlv2oboxTtQ7bz72QcbUI/BYKwEhDQu6s/s2i6ftHaphlKcZoK+cJ6Ya7/c3UCmp0rhZJmYDh7IWs3lVTZIiiEG3lWLwHi/O++GuZxfxfB1F8aWU0QFRqq5Ah9Fbi6+8vvjkMYgmHwUDPhyC7yRdpZvFrjzfqwV/RmdnrOf9byDAwh5w3yIWTGitSXL/w3OUK0hiMQA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3766.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(8936002)(4326008)(26005)(86362001)(6506007)(53546011)(7696005)(186003)(76116006)(6636002)(52536014)(2906002)(55016002)(6862004)(33656002)(66556008)(66946007)(64756008)(66446008)(66476007)(71200400001)(54906003)(966005)(9686003)(478600001)(5660300002)(83380400001)(316002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: eJNPqL9Na4J9WfDOqQU5ylAr/7u1ibPzDc+iu9U+kTVNYgHCYJXUJ/oPeOnrFiD7qterKWOcXLK9XFj21XZMhNcFwtIJ1Dmq9xcT5wDVXfFNPywwsXOyBbWU3x8IFctidCOEythMOof2YtfHUxRfeExb+QkaMCI5qQ7BdCULa8AA+0+42OzQBX07ILkva4Fe3/WBtMBTitrn0Ol4Oburb4OJ1LyHe7AZebYcEYy+vOQpWjT7LflWxPq+X8aNF+NR2apMdewXDuQ6y97tIIxCfj8Nmgzi1zTTeFAWz3XfpTra2BzS8LOBBh0Wo66S1oYMXd9M+4NUuSgxxwyyjmRh5xL49IjdtWFDQZsUbA5E/Tc31K02nmd1omnXQiFkoDFTWUz0Slhm5eMPcqA7DU3aXPxiBaPjACMWCo442a5xY41hHygrOyR0ExKA9ZkXEoUEE/aVBxH13hcT0+bbhQsYN40cVSGGeve5G4I70iyAE9Lk56wX9CmcGDeHcHHUxErsBP/yarf63Gw5MuIgVsBDxkJEH4S+DSDALa22Q53mDy/7WJBrmh+Vbin2O4+9Ad5/Jq6ygLnsKPvZUQecP5AyLnQMcqYLlJ2hdyoWOAU5D7Z6lIJpzAKk9mVLMowQ/7+z5Ni8uzVPhJalYNRZaB1Wkw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 264fd0f7-670f-40d5-2287-08d839e442b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2020 08:39:40.4921 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wcvjjqt2gp7cvbE1B3HGKBoamKfte65aLemfxox/hqKJDqKYjIyo6My8UanaYnagULS11Mq9qAODcyWDx4TncA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4232
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
Cc: "Wu, Hersen" <hersenxs.wu@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>,
 "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]



> -----Original Message-----
> From: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>
> Sent: Wednesday, August 5, 2020 10:55 PM
> To: Lin, Wayne <Wayne.Lin@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Lakha, Bhawanpreet 
> <Bhawanpreet.Lakha@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>; 
> Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Zuo, Jerry 
> <Jerry.Zuo@amd.com>
> Subject: Re: [PATCH] drm/amd/mst: clean DP main link status only when 
> unplug mst 1st link
> 
> On 08/04, Wayne Lin wrote:
> > [Why]
> > Under DP daisy chain scenario as below:
> >
> > 	Src - Monitor_1 - Monitor_2
> >
> > If unplug 2nd Monitor_2 and plug in again, observe that Monitor_1 
> > doesn't light up.
> >
> > When unplug 2nd monitor, we clear the 
> > dc_link->cur_link_settings.lane_count in dm_dp_destroy_mst_connector().
> > However this link status is a shared data structure by all connected 
> > mst monitors. Although the 2nd monitor is gone, this link status 
> > should still be retained for other connected mst monitors. 
> > Otherwise, when we plug the 2nd monitor in again, we find out that 
> > main link is not trained and do link training again. Payload ID 
> > Table for Monitor_1 is ruined and we don't reallocate it.
> >
> > [How]
> > In dm_dp_destroy_mst_connector(), only clean the cur_link_settings 
> > when we no longer do mst mode.
> >
> > Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
> > ---
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 5
> ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git
> > a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> > index 2c10352fa514..526f29598403 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> > @@ -415,7 +415,10 @@ static void dm_dp_destroy_mst_connector(struct
> drm_dp_mst_topology_mgr *mgr,
> >  					   aconnector->dc_sink);
> >  		dc_sink_release(aconnector->dc_sink);
> >  		aconnector->dc_sink = NULL;
> > -		aconnector->dc_link->cur_link_settings.lane_count = 0;
> > +		mutex_lock(&mgr->lock);
> > +		if (!mgr->mst_state)
> > +			aconnector->dc_link->cur_link_settings.lane_count = 0;
> > +		mutex_unlock(&mgr->lock);
> Hi Wayne,
> 
> The change looks good to me.
> 
> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> 
> Just for curiosity, do you know why we use a mutex instead of 
> spin_lock_irq for this case? FWIU, the spin_lock_irq behavior looks 
> better for this sort of manipulation.

Hi Siqueira,

Thanks for your time.
AFAIK, changing mst_state (e.g. enabling MST mode) involves some reading/writing steps on DPCD which might cost some time. 
> 
> Thanks
> 
> >  	}
> >
> >  	drm_connector_unregister(connector);
> > --
> > 2.17.1
> >
> 
> --
> Rodrigo Siqueira
> https://siqueira.tech
--
Wayne Lin
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
