Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FFDC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 21:23:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5E4C619F7
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 21:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E4C619F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E9736F49C;
	Fri, 26 Mar 2021 21:23:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B9AB6F49C
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 21:23:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIuwu9ZarvDIYQScZdaMpTqb82ID+1ET4AA9kOrU+UfG3yxrlkM4ke/GQb7qs89jYLI8aQWl7YdWkCAiWEf0Q0SG8jG9iwUPxkaowPcS1Fk4SFhuiC5IJreIQ/oFyFWCTQ1ytBwshhXIvrzHDzhk2RL/yNP2JyF53eZh5AurvyGUBLorWob1RoKLzZQjbpw+LnkwmJKoju6SCz1ahtllJ1cJ39Spj/vT6mtESe4pm1ZwZZZiS98KZzwJPsNqttfOcTjklhc8RThakAX2cFS4szUA7cBrTohQUq2UQhTudYrMPc06OgwmrEpWywkpAMF+j3vmV+/yaOQMzfQ/rLA5gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwh5C3vkiSc2Wx7gFFgDFULx9DCjHkXU0HFTn7Q1/6k=;
 b=HHlbU/Nezo4+nvNIlxmuuyn1CQdHedl/GHR1yPLgFRdInhgH+J02Cv0h9mGBrvxC+d4W/lSuZI1PSL4zADeoDXkJnoe/GQNiMtOOZACJTDCLne1JIppYAAntzQrF6jP9jGScjkQ2HuA3VgHKNL6iTdgbqdVRgtqIba8L4lsV0a8XeDx7CHkFe5oshNQdYvCNfxYw7nx7MUUj2D/xke+tmKhzY8uz3P78iAKVhrUOm8I4BIkRo3tfRavrN6mOpcfZ7DVt6hBBFJF/JIL2DpLwUY9YLCil8irQcYHNQpJ6TjC6Cw7ztKO1QVPHl/k7RXfx/6xyY5O5JY1XlW6XDcaY0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwh5C3vkiSc2Wx7gFFgDFULx9DCjHkXU0HFTn7Q1/6k=;
 b=sRQUxAQ0vMAIUVCtIrZt4P3tpSmelda9H3jNfM1zzYAm/6asLqa0tRAfi+NWWDh0eq8EpTXwsUPPfj8dnTD/SpwrHWuoCtkxeYY0OwANz9x93sZKFgpPBguD0QX+k/imdtsxD8SvK4+5wVdmPE6D/IXa9Jpf48ow/W0zPp7Wink=
Received: from DM6PR12MB2971.namprd12.prod.outlook.com (2603:10b6:5:118::28)
 by DM5PR12MB2373.namprd12.prod.outlook.com (2603:10b6:4:b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 26 Mar
 2021 21:23:04 +0000
Received: from DM6PR12MB2971.namprd12.prod.outlook.com
 ([fe80::7d77:8839:4114:3bb1]) by DM6PR12MB2971.namprd12.prod.outlook.com
 ([fe80::7d77:8839:4114:3bb1%5]) with mapi id 15.20.3977.026; Fri, 26 Mar 2021
 21:23:04 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/swsmu: don't bail early on hw_setup on resume
Thread-Topic: [PATCH] drm/amdgpu/swsmu: don't bail early on hw_setup on resume
Thread-Index: AQHXIfnLvVMjV1VKNkW3sRwJp4caJKqVwpQwgACNd4CAAHI7gIAAAopA
Date: Fri, 26 Mar 2021 21:23:04 +0000
Message-ID: <DM6PR12MB2971CB6EC26B32A0755EE0BF9E619@DM6PR12MB2971.namprd12.prod.outlook.com>
References: <20210326043731.779691-1-alexander.deucher@amd.com>
 <DM6PR12MB2971DB53BDFD4B623C368A619E619@DM6PR12MB2971.namprd12.prod.outlook.com>
 <MN2PR12MB448857020BBBAEDEC70B6FB0F7619@MN2PR12MB4488.namprd12.prod.outlook.com>
 <CADnq5_NUnH0Qs5L+JBhr4XfhurZScXztQhJvRjWt0NKJ2Xh-7A@mail.gmail.com>
In-Reply-To: <CADnq5_NUnH0Qs5L+JBhr4XfhurZScXztQhJvRjWt0NKJ2Xh-7A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=4a329f65-3956-4273-8fe5-1da95d6b013c;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-26T21:10:20Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2cec15ed-011e-4864-eb0b-08d8f09d579c
x-ms-traffictypediagnostic: DM5PR12MB2373:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB23733A3641FD963768B34EA59E619@DM5PR12MB2373.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K2pFGJC7YeYgaaKpH5rSp3Xv2/h+1kHJdCW1BUd9RL21j2xQdb6QMMVDa7k6gQED0y7ZkhK+sYDcWQphr1spV1kDIlCWzLzGnF41AWbYGCy3dkbOPPQ141OmRJYVlJsZme0jM/SnUX+UXdrezluUfxNiW9wik+6H5VW05R0RZkfeeWs6BcUy/mh1aUD4g02OfntSQ4RJhoyD+BL+UWmyvkVEuHt95MHmim6GCTR0shZ3JgnzDs2VRcoPBqmJs502C90OneN3peFn8JTkSeRErqX9JRc9QGLzmUtz4rTKEOuyFEO6Rp4miMlsnkjRpzxH54taZoY9LxpVqWWsSeKEPqaPNBCetXiMUWNaya0OjBO16Z4JhpThZvrpkeCtSjRR5w46GXWCTRcnb+HBQPHbwgwAGHbrjpweNmV5zPiCBuaQAI3ug5Nkuw+YkCQXcObzy39UUA+v8wFfGWpMrpyRT+sGW29AAq2Uz98Pjq6uw9T+B1fOZ3GgAdPAeVkCODuXgLFkQ/Xq1oYB2H9pOnQrhIq+pLCYAUaeJLQxz8rcPzdJFPBYFcYtywJYP+ZHT8P4wUXPzRU6z1aso3c0Tax1PAAn90EYjXMfH/1i379Dn/TM5RBjnD1EI8aE0CI/2kI24pyiaLKdeRyMdrYScfuGFOSVWyqqn7Y2L2Jb5L/KtqPyrPDW3GwKJE6Ppr8x3s10
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2971.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(6506007)(53546011)(8936002)(6636002)(8676002)(478600001)(38100700001)(966005)(71200400001)(7696005)(66476007)(66556008)(76116006)(52536014)(4326008)(54906003)(9686003)(66446008)(316002)(26005)(33656002)(86362001)(186003)(64756008)(66946007)(2906002)(83380400001)(5660300002)(55016002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?JQvt9CtW18L+EZV26G63FEKrcULwWxK1SlpkevOcwJ0dE/MVbk+NAa1hdlIC?=
 =?us-ascii?Q?VqybbAOiPqsL8rDnW0+9qd41jLy7hn4VJdKuFeyqyYR3s/JxE/kQBtsC9V+v?=
 =?us-ascii?Q?qC4k1gWqu2GrIK5QfGfgyIrTiFWaJATGhaD1yN+CkrJzFyyKEq0htJDcLx/w?=
 =?us-ascii?Q?evRW+lGtbTEYAiRuQ4ar6nEXfpWg74WICFbJa16yh/Tt8QbihLevdNGYOZt0?=
 =?us-ascii?Q?KXVw79SBSmsfdNomHGBCXtuwJCBprcxNb7aDUO6Z2bDimfbC0Ob/jJ8m2Zvx?=
 =?us-ascii?Q?yXNqFkwaYrrICAhWr2411/kypx2OXm6ZX/SoYofzUBIqoGQtEcy3gC1K5MiB?=
 =?us-ascii?Q?t9W/R5sUtW6AFEzq7YNsVtblwejyDh9tAvz71KX3ljQbxCxNqNcgUswqm1Wp?=
 =?us-ascii?Q?vdnZlmScgo3fY8VGwoiSQ4ji7qhy/P9r58y4L7kgkkvAiogYE+J9Ks46eW1k?=
 =?us-ascii?Q?ZVC9rEoVxQyefpcazJ3W1dqYCoNOWgFHIyDfiAfXxi/GmgsQw5/C27Ivo5k9?=
 =?us-ascii?Q?VjnD7Yc+9zMbSOjg3xW+fOp2IpeW1Na2je3qM0MAzbd+ZYwgL0K6wY7RKSwT?=
 =?us-ascii?Q?GKPbwuiZVDjPrD2EPjkQD5IZlEZnfoLhH3YhYDV8CmsimVkC9PcEl6iHPBmh?=
 =?us-ascii?Q?4ZcMUoNKzvWMBeWsnXhISOVMIuS3fMF08pKXUcYwkqDP06Dpzo6GXruxQPiP?=
 =?us-ascii?Q?ppZBwI+0AV3kU2rA/Xu3xtjtPft3aR1vrfmq19Gzpu0+s0hb4kYF/0wynspX?=
 =?us-ascii?Q?lHQCy93p7W/+QHq3R3PFVTn1ZSGbb+x76vcH+STcKnAz5Rn0LbAqpaTZwboP?=
 =?us-ascii?Q?mY+7KPA8HfSLB5FR7Jfa89sMOGPQZRyblNnMUg0gFyxFeTf+kXl9dd77OALN?=
 =?us-ascii?Q?tk8EIBOfMWhTKXjt0sopqqcU/XXTKznd9H7k3pyzkBCnVuHE3rlu+kH3mH1v?=
 =?us-ascii?Q?Py4atTXraE5dEAIPhpMwAaiE5hFDj2HU/DkBwXcLXpSHcTBIhacBk70Y7iCw?=
 =?us-ascii?Q?hibduoZBvNDlvt3dTCETP49fPeZwomTiOOkQCv+9+rWVBFfU2Kt3jyfcs5OI?=
 =?us-ascii?Q?a0XOidGg+izrGyC8mDADyiyf3azwGCwqkrX4WhkmKmYGyN9etVVLEgruue0G?=
 =?us-ascii?Q?25BKRr/FSHN3CuQjTT6PFjAyTSwr78HWGDdLXUFGt505agurvocI+nKMH9oK?=
 =?us-ascii?Q?pTKltTuqGtbZuIvIrxoWsXZIbE+MBXESSPoyWIGtdPhQzSzr6HbAO1p0/4+u?=
 =?us-ascii?Q?z7Mxj7LlcVW+/F6OM6woepVw3IAxH2fwsCPt0Oi/ddcwBHq07cTEl+dOhTrf?=
 =?us-ascii?Q?EHQ/AsR+F2FO9FQinX9tfrr6?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2971.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cec15ed-011e-4864-eb0b-08d8f09d579c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2021 21:23:04.1599 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j1XJleHE59Y5U45sY/5pSKQNBv9yVG4OPS1BxV3LX/c3n7zCJ3JEWY6wPEE6NEeU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2373
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
Cc: "Sun, Charles" <Charles.Sun@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Cornij, 
 Nikola" <Nikola.Cornij@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: 2021/March/26, Friday 5:01 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: Liu, Zhan <Zhan.Liu@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu/swsmu: don't bail early on hw_setup on
> resume
>
> Looks like RN is immune due to the way it's is_dpm_running function is
> implemented.  Maybe something like this is a better solution:
> https://patchwork.freedesktop.org/patch/426293/
>
> Alex

Thanks Alex! Yes, I agree, this solution looks better to me. Since we've already done the same thing
for RN, it totally makes sense for us to make VG immune as well. And we can limit the influence
to VG only in this case.

Its self-explanatory that this change can get the issue fixed, but I still gave it a run on VG
and confirmed the issue is indeed get fixed here.

I will add my "Reviewed-by" under your new patch.

>
> On Fri, Mar 26, 2021 at 10:12 AM Deucher, Alexander
> <Alexander.Deucher@amd.com> wrote:
> >
> > [AMD Official Use Only - Internal Distribution Only]
> >
> >
> > Can someone double check this on RN/CZN with S3 and S0ix?
> >
> > Alex
> >
> > ________________________________
> > From: Liu, Zhan <Zhan.Liu@amd.com>
> > Sent: Friday, March 26, 2021 1:46 AM
> > To: Deucher, Alexander <Alexander.Deucher@amd.com>;
> > amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Subject: RE: [PATCH] drm/amdgpu/swsmu: don't bail early on hw_setup on
> > resume
> >
> > [AMD Official Use Only - Internal Distribution Only]
> >
> > > -----Original Message-----
> > > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > > Alex Deucher
> > > Sent: 2021/March/26, Friday 12:38 AM
> > > To: amd-gfx@lists.freedesktop.org
> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> > > Subject: [PATCH] drm/amdgpu/swsmu: don't bail early on hw_setup on
> > > resume
> > >
> > > The SMU comes back up with DPM enabled by the sbios, but the driver
> > > still has to set up the SMU/driver mailbox, etc.
> > >
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >
> > Reviewed-by: Zhan Liu <zhan.liu@amd.com>
> >
> > > ---
> > >  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > > b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > > index d4b804c7b986..462917d4d5e2 100644
> > > --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > > +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > > @@ -1102,7 +1102,7 @@ static int smu_smc_hw_setup(struct
> smu_context
> > > *smu)
> > >  uint32_t pcie_gen = 0, pcie_width = 0;  int ret = 0;
> > >
> > > -if (adev->in_suspend && smu_is_dpm_running(smu)) {
> > > +if (!smu->is_apu && adev->in_suspend &&
> > > smu_is_dpm_running(smu)) {
> > >  dev_info(adev->dev, "dpm has been enabled\n");
> > >  /* this is needed specifically */
> > >  if ((adev->asic_type >= CHIP_SIENNA_CICHLID) &&
> > > --
> > > 2.30.2
> > >
> > > _______________________________________________
> > > amd-gfx mailing list
> > > amd-gfx@lists.freedesktop.org
> > >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
