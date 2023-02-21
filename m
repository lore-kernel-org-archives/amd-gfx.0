Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4765BC6379F
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Feb 2023 10:07:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E70C910E082;
	Tue, 21 Feb 2023 10:07:01 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::60f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF3E810E082
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Feb 2023 10:06:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JR5eCH/qkVj4eut9c9bQTWG/7yWHsje6DWIpCFBEHAAAHtTrvbL7LQz2q6VbeApOQh2sS5z/6sN+yIzZjW0n80IfSh0L/TJA04rj4S6Zshi1kR7Ymnq8mM16nLcR89FJYgw/rlS4/wWR674G71bhF5lhAlh0A3Fml3fJelttaHr4ivZvyxb4NNCh7keNUI0q2HTWFV9Bup+n7rScOcvEOUtbq0VS5ABpdcz3Yr1rkuXaCZOI14WQSRXB8dQYt71gCaWFPjyere7dZEmdwBlUNIM31HJAulBFZw8CT4SmYwHyeDr8vRcS2weX40rLoVW4Q0GjEiSiRwWxf4x45hmIcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vi3twBXJ1fK705kgcsEet9TpVUP3vcLshBfXtpojy2E=;
 b=c7uli+7XSkbbIKqsLEHq89fQVdpynCZTELgTxSQM3TDCfhnoEBuHtWVptvKwXJGwk9RU+IvLxZchsn3xORlR7Ud2aVYgeS3DL0R4wuWAwtM595qIHDBxgLy0vwS+nNOxXcDoQKbk4Yo3AkoVPL3/epMn5XqE0cZ+s0x2Uz0vVRgSEYrzFe+B3fxGLp5lNgBe98/gNnZ3hdaHpOeRu/gIZp5AEeHS/0LcAQ0v6vIR5xnjxr20A5CXThH1doNeJkRFVMX9WHwPLzGvDScqw/3ehgVIpL2vg31da1hjCn924Z0t5gDbQSRvJaHfG6VfR69/8XT305QjsYtMuetoHg5j6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vi3twBXJ1fK705kgcsEet9TpVUP3vcLshBfXtpojy2E=;
 b=TG+9LSwtJzvX/YsjMF3mB1fjNA09pFbpwCTxnOZIKga4v1UrAIhjn2jUTdpiTxf/MLh3ik3BM9bCsSom7Cr3uza/3ZtDqb90tJHZys/R/5Uspp03V8dohKVuI/IqVN9Wx8HJzoeDqDs5x9P1Xx3AOVL6Es4ww6JL/lW2uAutWhs=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by SJ2PR12MB7917.namprd12.prod.outlook.com (2603:10b6:a03:4cc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Tue, 21 Feb
 2023 10:06:57 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::e52b:f6b6:5b71:cd92]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::e52b:f6b6:5b71:cd92%9]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 10:06:57 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: add bad_page_threshold check in
 ras_eeprom_check_err
Thread-Topic: [PATCH 2/2] drm/amdgpu: add bad_page_threshold check in
 ras_eeprom_check_err
Thread-Index: AQHZRc6jE6VJNDh3Zka6vi7SRmU+e67ZI44AgAAHiJA=
Date: Tue, 21 Feb 2023 10:06:56 +0000
Message-ID: <DM5PR12MB177057CFD88CF8F4F3B99626B0A59@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20230221082923.19190-1-tao.zhou1@amd.com>
 <20230221082923.19190-2-tao.zhou1@amd.com>
 <BL1PR12MB53340BBA8F15388A518EE59E9AA59@BL1PR12MB5334.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB53340BBA8F15388A518EE59E9AA59@BL1PR12MB5334.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c96f9d5d-088b-424d-8080-08b61214d598;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-21T09:33:39Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB1770:EE_|SJ2PR12MB7917:EE_
x-ms-office365-filtering-correlation-id: 486e8050-1d28-4b5f-49ea-08db13f35d75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6UNkyjB9ZXxdMFOg30M9HIcSjxN3MfAL5Z6WOX5/zpVx7caKYg2UUjJOHBS4Uy3vC8Ugoaq1Iw2rmt598T61C9pPEivGQg2y/Yao0y6Sl+a7DspXGtHtLpn91PJaWx8xEqX5+kcXGp3gwP2QD3Q1dRAQtQ67LtRurKkisTck7bzYp0ztv+XkCeXwrGqux9cIrM05Df/IkdZfDml4hu5e6sNRQqTUkvpXQuLKyyLUM8QrADZ9Uv04816thmkLGwcDgHKQefpiN2UdBIuJ1jHuQ3C1k4wDRWe57Y8tAx8XlFiib374O4iummZ4O7KCeOZClSFf622kK5zCFkjNbpY1Zv8beEK0gseyABgHTpFwlLtgMvMconrkj2zSgiqkzGq312NxHKljypQnR2iNSdbt71puo17d4kah4rjlafoP/cG5dmEaAM8hzrtyWVOcMZytrKRcDSgguIW+sokY27Wsh7Ec4nP+qjJBi/hudOTJk6Cg0adTnZV69m9O5CX+w3XCPetlkeyMET590tCDnE5IinM4FH9nf5qUiCrV8Iubx8ywWoC4WmRTASWiTqYQIXumAWjbJXD92kkzQe8kqvPjO7Kf3Sq7snAo4JmY3vTdCL7clSgjf2eHuM19VgvmknigtPDOSoeMwqIM1tvTxSsM1uvAYY45pSgyXSotN5cEe9BcbutjUMGGgSaQJ45uiWf5hFoVfHYZsM+iiImVffhRRA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199018)(122000001)(110136005)(66946007)(76116006)(41300700001)(38100700002)(6636002)(8676002)(66476007)(66556008)(66446008)(64756008)(316002)(52536014)(8936002)(83380400001)(478600001)(5660300002)(7696005)(186003)(2906002)(71200400001)(9686003)(26005)(86362001)(53546011)(6506007)(33656002)(38070700005)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uhriT8n0u6qMyqR7BoRs2p9GNHwwHc+LHDtwmOvU7aH4yJJKAKb6xbpdAHUf?=
 =?us-ascii?Q?TncS8xZHPn5T1nxl0f2ygooIUziyy7sCtpbhtcHUoQNze1CYTV8wQK0tzx+u?=
 =?us-ascii?Q?uolaXvbl+yFFQx0JIjg9fuNO6HGhV9Yqa6Rhi3Ihgi16+g/RZBJZs/48MbFt?=
 =?us-ascii?Q?t5NwBMT/6dHVdyQdQmDPqNvAlCKNfwA+zSr/eC8UG4EXFmAEGCz/5Fd6s59K?=
 =?us-ascii?Q?YV5qXWDO9OjfS3lnVdjpV2IYC6Q2jo1rpbKnZN96CJnMs/Ab8ATqeUUEmC9b?=
 =?us-ascii?Q?s0rssN8pvCiCw/+yJIoks2+DP9TJHlxocJOHc4GD3N/bT5EbD3kaEJMM49rj?=
 =?us-ascii?Q?YX/jrkcbbDNeL+J/7sA/ZVsH2V8l7oWBpkrqw0lBvzBIiACwVLz0C6DmrXm8?=
 =?us-ascii?Q?0tpXMKWNcqG5Xmxl7jceW8QVcFBj7lbPZPspF5d3mkFnWvMuAOAsrFTTtlZ5?=
 =?us-ascii?Q?qzO2AOg0o698e9aTwBA1Lm88ixHIsKZATIdqMxtxiLJk5Uc1CWD8VMX8dvf4?=
 =?us-ascii?Q?+unLID1dIcWofvTXdVz6lBwrW63WSpDbgI3IsPUwIbMeX7Kv1TF5Sc9s3jFm?=
 =?us-ascii?Q?iZ4yR95zzfnI5uDphHMVAST4/VLaToK/Q4Nt8bWFbNmNdc7k81YgsskRM363?=
 =?us-ascii?Q?eb2admN5e3qhR9gOMhmX62Gy9G9kN/y+LTUO1WFpUEL0e7FN21CX6weakf5y?=
 =?us-ascii?Q?mxiBj0D87PRCsdtKiTbjv902R2AeRaTpqECZ19gGiRS5o6Aj/Wfs9rSTpnzn?=
 =?us-ascii?Q?4XfXYTHuYtRMArZBapsxH+nqYhAN9emzvF9Jm6r22Oaner7PKHvDWKtiz17b?=
 =?us-ascii?Q?7pd2whB/SWWyDKbTEEAqBFZConviLlN7jLizb6/+bSv3Kj78vksxEcSOGQ7v?=
 =?us-ascii?Q?/uyZn4bC/iFopsB/RPHeW0nGxqiVqXJxE8Siw2+TuCFjAdwKehUiFIh2vUrr?=
 =?us-ascii?Q?x1ef5GUCdyhEpht0b3TxmdFhKce65bvqb1PMdJJHjL0rAnF7/ovy3xM0uCfX?=
 =?us-ascii?Q?LMJXSIC+cZYkcq+lmAIcIpaENhAFllNfGO9jGy0wiAozDIVn6+VEU7k5hcGa?=
 =?us-ascii?Q?dQvkuCWB7432U58f/yOz6KBx3+vBmdFyPgq4hQVm0iG13HAYCBB+PwQiMFTu?=
 =?us-ascii?Q?c7CynjV0gwU9+IVxxVy5RTpK32G2gu/aidpXFz80+8kUDZwp7T1ywdiHJGsb?=
 =?us-ascii?Q?ma/mA7bCluaFd1GKHqyw+vwv47niobzsumEWNAvwHQuut+CIYJwvdJCLPgL7?=
 =?us-ascii?Q?keejerLlRMPmZf6ZNMkw6PJNS7C95haLFs1vtC+yjcDIafNsFdUFRxW8WbTR?=
 =?us-ascii?Q?8m7C9y2Ba+oMNxuOMmk5oAnYzmcrBtLULI3+q/SnE4irBr7UW9RvNcsacxZG?=
 =?us-ascii?Q?6WuwB2SVe6Paq6euFVFUc8iyEsZ15wTfmtVrn4MW5r6lyX7NnQkh1jieKw1V?=
 =?us-ascii?Q?vjzXra+6ozmxTD6g3Pb+4Apmdp9ZRbS3oqNrvg35YDAmiMy0SfKwRGkLr3yX?=
 =?us-ascii?Q?sCbGyQJlKHG0JVaJvIWRUiNCE8v+wdr0FRxgU3qaoa4HgxV8+Fd/6zFoDX0n?=
 =?us-ascii?Q?DneOEnYPkxwosx6FeHI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 486e8050-1d28-4b5f-49ea-08db13f35d75
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 10:06:56.8380 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WAVtaXInBLuQP9NCu/ZtzGBgvnY04ESnQoJsGuUOeAAA0EFH+fFGzhKKbNaG32MP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7917
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

[AMD Official Use Only - General]

> -----Original Message-----
> From: Yang, Stanley <Stanley.Yang@amd.com>
> Sent: Tuesday, February 21, 2023 5:34 PM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org; Zhang,
> Hawking <Hawking.Zhang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>;
> Li, Candice <Candice.Li@amd.com>
> Subject: RE: [PATCH 2/2] drm/amdgpu: add bad_page_threshold check in
> ras_eeprom_check_err
>
> [AMD Official Use Only - General]
>
>
>
> > -----Original Message-----
> > From: Zhou1, Tao <Tao.Zhou1@amd.com>
> > Sent: Tuesday, February 21, 2023 4:29 PM
> > To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> > <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai,
> > Thomas <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>
> > Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> > Subject: [PATCH 2/2] drm/amdgpu: add bad_page_threshold check in
> > ras_eeprom_check_err
> >
> > bad_page_threshold controls page retirement behavior and it should be
> > also checked.
> >
> > Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> > ---
> >  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 20 ++++++++++++++-
> > ----
> >  1 file changed, 15 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > index 9d370465b08d..c88123896fe8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > @@ -417,7 +417,8 @@ bool
> > amdgpu_ras_eeprom_check_err_threshold(struct amdgpu_device *adev)  {
> >     struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> >
> > -   if (!__is_ras_eeprom_supported(adev))
> > +   if (!__is_ras_eeprom_supported(adev) ||
> > +       !amdgpu_bad_page_threshold)
> >             return false;
> >
> >     /* skip check eeprom table for VEGA20 Gaming */ @@ -428,10
> > +429,19 @@ bool amdgpu_ras_eeprom_check_err_threshold(struct
> > amdgpu_device *adev)
> >                     return false;
> >
> >     if (con->eeprom_control.tbl_hdr.header =3D=3D RAS_TABLE_HDR_BAD) {
> > -           dev_warn(adev->dev, "This GPU is in BAD status.");
> > -           dev_warn(adev->dev, "Please retire it or set a larger "
> > -                    "threshold value when reloading driver.\n");
> > -           return true;
> > +           if (amdgpu_bad_page_threshold =3D=3D -1) {
> > +                   dev_warn(adev->dev, "RAS records:%d exceed
> > threshold:%d",
> > +                           con->eeprom_control.ras_num_recs, con-
> > >bad_page_cnt_threshold);
> > +                   dev_warn(adev->dev,
> > +                           "But GPU can be operated due to
> > bad_page_threshold =3D -1.\n");
> > +                   return false;
> > +           } else if (amdgpu_bad_page_threshold > 0 ||
> > +               amdgpu_bad_page_threshold =3D=3D -2) {
>
> Stanley: it can't guarantee use to set amdgpu_bad_page_threshold value as
> expected for example -3, how about set this if condition as below

[Tao] Since "<=3D -2" and "> 0" can be treated as same thing here, will upd=
ate the condition to "else".
The "-2" isn't retired, it indicates threshold number is calculated by driv=
er.

>       else if (amdgpu_bad_page_threshold) {
>               ...
>       }
>       And in patch#1 the value -2 isn't need anymore.
>
> Regards,
> Stanley
> > +                   dev_warn(adev->dev, "This GPU is in BAD status.");
> > +                   dev_warn(adev->dev, "Please retire it or set a larg=
er
> > "
> > +                            "threshold value when reloading driver.\n"=
);
> > +                   return true;
> > +           }
> >     }
> >
> >     return false;
> > --
> > 2.35.1
