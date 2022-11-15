Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B29AC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Nov 2022 19:21:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D23B10E14C;
	Tue, 15 Nov 2022 19:21:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5D4510E14C
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Nov 2022 19:21:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrFjsMt00d0pIviyrkhlrk0aYJ8X0khaTEMv7Wc+NahCTZjwIgd+whrLEQ64+1LIuTa24oEyczsP1X34U5ceSuHo4aG6adOwvvn2axZKd1faKPagBtS6a3T9jxowjSrmGE+2HbTkJ3DPZz8a1wc/A0Ooix9rSlopqOzJxtbFzERRrrBDZC0HItGwQ9fhZXfd2D4Sc8tO0vAsw/XsKc3SbBYJrGzKLXTVsC91PgJ/VA2zCR4SOu11oYIFnPwga4XAZ+uJNuVN57MNrRw/PSrHYvewcP1mSVVkfnnzPTP3m+6blIvztlzVVSnJ+oXZHBx5aDW5b3rNROtthW2U8L6usQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6m6SNIin3oqImpuvk5v13/UorcHO3jj2enaLSUhbrY4=;
 b=hLUNo0SgH6qYva4W8ICDK+jX/CEWHVTQuT7sclclDoV+QBUXGbQW0dSWVeo8MhLIfA5Qp14MYG5q7J6Zk7C9X977Tc8bSV8bb0uqypFCFihZHnmbfwll78Lh5S8btK25BB9rs1nHTQ1B/c1sLwNDpzV2/hLGbd/QDUTkzmmmu5l8vLIH0m5Zd9cXCW6EBflrgl92EhABWAisQKzAMqDzhphfy98hVcky1CC7sETL97RagFDKsvb5s+abBVvGSZbkoyVdzf+rxpbeAnICxUAwiVYezTcItfJrvvh4/ehr3U13PKWHvHMRWsWCdraeDO6i/pOEHkkeR9S0EgWqiYBbQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6m6SNIin3oqImpuvk5v13/UorcHO3jj2enaLSUhbrY4=;
 b=Q45guFRNUchQ9iOCnCyc09KovYt+nJpCgZ2YVwMxlmqnUssKLtNGbY/OMf0rDUDGzgf/4GQy+ONTf6Ac2J+orwZpGr95HuyiiCaB6mM1aL2R+8jkOq3XEcPTsUb2vhxK5sYk1fzludJ4W3BUNvy6wN7XvzFz71CpjKikJvn7XTE=
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 19:21:46 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::56c:96c2:3bfa:7f95]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::56c:96c2:3bfa:7f95%7]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 19:21:46 +0000
From: "Rizvi, Saaem" <SyedSaaem.Rizvi@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Li, Roman"
 <Roman.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>
Subject: RE: [PATCH] drm/amd/display: Align dcn314_smu logging with other DCNs
Thread-Topic: [PATCH] drm/amd/display: Align dcn314_smu logging with other DCNs
Thread-Index: AQHY+G0RYJNJP/Fm9keOkbbWbE8FoK4+67kAgAFZVACAAALZAIAAFVs4
Date: Tue, 15 Nov 2022 19:21:46 +0000
Message-ID: <BL1PR12MB517645F3598076AB110ADD1CFD049@BL1PR12MB5176.namprd12.prod.outlook.com>
References: <20221114210701.23185-1-Roman.Li@amd.com>
 <MN0PR12MB61018FC7358247F0A2D476E9E2059@MN0PR12MB6101.namprd12.prod.outlook.com>
 <BN6PR1201MB008440D72339B49E7E576CF089049@BN6PR1201MB0084.namprd12.prod.outlook.com>
 <MN0PR12MB61012DEA5F98F7F51BD8CD09E2049@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB61012DEA5F98F7F51BD8CD09E2049@MN0PR12MB6101.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-11-14T21:10:25.0000000Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0; MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5176:EE_|SA0PR12MB4462:EE_
x-ms-office365-filtering-correlation-id: 1d4ea99b-0899-40d4-d5d4-08dac73ea323
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ULKfH9cBNiofgaIyn5opcf/M7e6SGpKyrmGGnB2fsxrpzK1+CMccfPeUSfJPuycZ3UHHe0iQ3QMekjukxqanwcN784b1ah2r/d2jgdQbayFs31SrkExhew+/zF6pZqK4ykEx4CUjo39h+wx51OHyrXynLMA6MbKDfGF63Qq+sQXbm03llonHXI+HgzWwiOzOKhDUxRErPsk+1Iz0f5O41V0RHcsDYIRusz46fH0DDTCxBshhDT/AlrfEPDGywpbW6Vbd2LnJihXXbr2hER08Qy+O088SPQI7hWAA60xqZ9mhDSMrDBfvK3L9Rtpm3xf+i7Qtm2aDPTX/fSbDpBhnt7JbXAaqL5mbKKkJn4KHNTMhGxTGhZxHLcjblnnPeFFykpDLJ7CT48s7/D/wCN0FbE/InTO0Xg3FjsGI6HE0CHurNzEdNdwJRlIfXURdeY7rAGe1MzPqAE1Wmj1qbHBbPRJUp65pHLbBJOSbWxY8aTCNgUzyVC0/VRMkd5vFqCPhc7TBJFyhqrvWHuJCzLwmJ9oQI5im6EkCoW8vn+J4BJzlJBHgGOUqdL4KBzUg7luBygGZg3hTwouoxH3TheaU3NwrW8mn0CuI1FPVPYZjjm21zGicsg+4gmhFo7jlbh1ZdxVXM8k7XbTlnxZiM440ZaB/AP9hToMm3WbEMZKYGlhK8Pra0ELSZfQra1RNTGC+G07Qhi4YkovyyNu+IQ3dyKTNrAgfElt0E2CsWbMmlrDthRpMXPHo6E4ACpM8c1l0xwIPA/TGFxQjVqTk78G69Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5176.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199015)(38070700005)(478600001)(71200400001)(110136005)(122000001)(38100700002)(86362001)(83380400001)(41300700001)(6636002)(2906002)(33656002)(6506007)(53546011)(7696005)(316002)(66556008)(64756008)(66946007)(8676002)(66476007)(66446008)(26005)(9686003)(76116006)(5660300002)(52536014)(91956017)(186003)(8936002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?erp+Afx16aULttuiUdgmmM7zx00GLDlRCAkqFZBoi6HYxYQDg83rHlUJkrOM?=
 =?us-ascii?Q?DhhtchKahpB/hYTPKeoBngIlBbjg+8jRfWIzzWa9sXaMc5Tfgg4Zyj39Phx8?=
 =?us-ascii?Q?n72IEx8n5DgaZ50YmWnQ3fCcSCzxhNOmwk9s/4JqagUxw3bzg45Navhpp2vg?=
 =?us-ascii?Q?bUavkUA2Xf2gr/6OasuvoIYIS/yO8LUuxeWkE8PWgXkh3jnssFIfTQoy85Mj?=
 =?us-ascii?Q?UZ9K9RyFQsvIy75j6fclRluC6G17jMGEpkXeBSrFDKk1FtHTXfa7FtIF71a6?=
 =?us-ascii?Q?iY+t677qN6tWgBB5CtNvIvZsO3kM7RGFSJyu9JuKDlL56oIP9TRGOlt4mC1w?=
 =?us-ascii?Q?zpbVTx3DFoCH7TAix28gr1592Oi1+z96CyodGKwgLvuEp/fc/qFJGEqzt/lg?=
 =?us-ascii?Q?J/+Mb+NzBazX41tN5gkOSgkTcHvlLeU7aITqYb6ZpHtv0RvD+OcKgFtMKQTn?=
 =?us-ascii?Q?+CNTJf4LcDVb+wctnZZMgee2RPv+hIhixb46yo+Mho8mth/Fr8zgJaya3vZX?=
 =?us-ascii?Q?nfOz+bATlPKsRkfDyKu6H6IG69WQFATn+/vzgMfTYjHwiEUGOYP2PZHX1bBv?=
 =?us-ascii?Q?1zWWUwOijm61Hz69pNJvD+/Fp0s0q+QwzP9AQgXFpxjsY/qYvDhgY9BKzZmT?=
 =?us-ascii?Q?9BOqXy1IVRqIh8LIFujZUc7skxLB86Th++yCOwrBomoCfjkeJB0OPnvfgf83?=
 =?us-ascii?Q?F1xQAMg3IjVBA0dlDqVUsEB7jMFcmCZX8Wn1ZnR4kRyGO30dna89hI/Dzn4u?=
 =?us-ascii?Q?3phy6ydjViLiCap0P1UOjdBzAl3DTr7kzmJw1XCB+kPkbEUI3nvp3/lOzUAQ?=
 =?us-ascii?Q?BWwFlyL9URc8T1sgiwMKtCUPgEr2ORnKyeGueZFfSjLO4rrq8tdHhm9ZW65I?=
 =?us-ascii?Q?eqnA2Il7efayVkZWSC/vsV7XqKQVve33MAWdF0CO4aX5kJVPT6h6JbqV1YqV?=
 =?us-ascii?Q?u0O8+BVPn6iWUOoaz3Nt7IycRXIbWTXFbmyL5lsxh0mFX6BmdQltnBQ2VZAV?=
 =?us-ascii?Q?yFO+PzbNio0iT4JoLdAuHF34eCv/YQAvBAaoEc+dTH7ZK+zdYC823XcyrWo5?=
 =?us-ascii?Q?N+sr4ASXF5VY8KsKKQ4oJjNn8foDaFtnKNzGyclGlg7AC0p+enmGKu0G4xjq?=
 =?us-ascii?Q?6T2muiidiMRhu9hy1iroJhJ4ODHAnwvx0iCx1QyrRpH1forbFgMbovleDSYD?=
 =?us-ascii?Q?fFdi328Hi2U1J50y332y0D0qcdymAeTEh7icFJm3Va7XbiGMCSTV5chZ+OFo?=
 =?us-ascii?Q?1is6LoXBHqbWm8NHKtn0KXhKla2r1jBS34JZqzSVyEoj1a06e7jXm3di/Qxx?=
 =?us-ascii?Q?cjG9lfi5VfWUWXlSNQ3RdC2MINeNQ8P136mgC3hLP/x0nfWhItMS9hAztXlL?=
 =?us-ascii?Q?ikfZisdqy//w3fU+mMor701mZP8tF+/nEdoGSJ9QHKbUbhFa0/2mqvSgs+VG?=
 =?us-ascii?Q?2JBpVO11D0gYs2gixdZ1PirUNkDfgztLo6fK25u8/nrXTz0cLFGSoe+IcHl+?=
 =?us-ascii?Q?qWLXYN05HTxlxSC7XlUgevsPnfWoJ8dnGpIj3WPVGhd8voLkoyaD48CwxdK5?=
 =?us-ascii?Q?kBScKxrZZfzXqombo/b2qgiXcHnZM+pzttdD8T+FEfhe6W7vANwm3K0WY3xo?=
 =?us-ascii?Q?5g=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB517645F3598076AB110ADD1CFD049BL1PR12MB5176namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4ea99b-0899-40d4-d5d4-08dac73ea323
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 19:21:46.4968 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6+gewZn/t5lx98jWc3vO9zjFlL7PdEe9BAGJdh2/X1Kqkq9wZki+bFE2AqrPoBrANepYKU+FRNuiuTNEvVeu6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
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

--_000_BL1PR12MB517645F3598076AB110ADD1CFD049BL1PR12MB5176namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Saaem Rizvi <SyedSaaem.Rizvi@amd.com>
From: Limonciello, Mario<mailto:Mario.Limonciello@amd.com>
Sent: Tuesday, November 15, 2022 1:02 PM
To: Li, Roman<mailto:Roman.Li@amd.com>; amd-gfx@lists.freedesktop.org<mailt=
o:amd-gfx@lists.freedesktop.org>; Deucher, Alexander<mailto:Alexander.Deuch=
er@amd.com>; Wentland, Harry<mailto:Harry.Wentland@amd.com>; Rizvi, Saaem<m=
ailto:SyedSaaem.Rizvi@amd.com>
Subject: RE: [PATCH] drm/amd/display: Align dcn314_smu logging with other D=
CNs

[Public]



> -----Original Message-----
> From: Li, Roman <Roman.Li@amd.com>
> Sent: Tuesday, November 15, 2022 11:52
> To: Limonciello, Mario <Mario.Limonciello@amd.com>; amd-
> gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Wentland, Harry
> <Harry.Wentland@amd.com>; Rizvi, Saaem <SyedSaaem.Rizvi@amd.com>
> Subject: RE: [PATCH] drm/amd/display: Align dcn314_smu logging with other
> DCNs
>
> Hi Mario,
>
> Thanks for your comments.
> I replied  inline.
>
> > -----Original Message-----
> > From: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Sent: Monday, November 14, 2022 4:16 PM
> > To: Li, Roman <Roman.Li@amd.com>; amd-gfx@lists.freedesktop.org;
> > Deucher, Alexander <Alexander.Deucher@amd.com>; Wentland, Harry
> > <Harry.Wentland@amd.com>; Rizvi, Saaem <SyedSaaem.Rizvi@amd.com>
> > Cc: Li, Roman <Roman.Li@amd.com>
> > Subject: RE: [PATCH] drm/amd/display: Align dcn314_smu logging with
> other
> > DCNs
> >
> > [Public]
> >
> > Conceptually makes sense to me, but please see below comments:
> >
> > > -----Original Message-----
> > > From: Roman.Li@amd.com <Roman.Li@amd.com>
> > > Sent: Monday, November 14, 2022 15:07
> > > To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > > <Alexander.Deucher@amd.com>; Wentland, Harry
> > <Harry.Wentland@amd.com>;
> > > Limonciello, Mario <Mario.Limonciello@amd.com>; Rizvi, Saaem
> > > <SyedSaaem.Rizvi@amd.com>
> > > Cc: Li, Roman <Roman.Li@amd.com>
> > > Subject: [PATCH] drm/amd/display: Align dcn314_smu logging with other
> > > DCNs
> > >
> > > From: Roman Li <roman.li@amd.com>
> > >
> > > [Why]
> > > Assert on non-OK response from SMU is unnecessary.
> > > It was replaced with respective log message on other asics in the pas=
t
> > > with commit:
> > > "drm/amd/display: Removing assert statements for Linux"
> > >
> > > [How]
> > > Remove asert and add dbg logging as on other DCNs.
>
> I will fix "assert" spelling before merging.
>
> > >
> > > CC: Saaem Rizvi <SyedSaaem.Rizvi@amd.com>
> > > Signed-off-by: Roman Li <roman.li@amd.com>
> > > ---
> > >  .../drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c    | 11
> +++++++++-
> > -
> > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > >
> > > diff --git
> > > a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
> > > b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
> > > index ef0795b14a1f..2db595672a46 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
> > > @@ -123,9 +123,10 @@ static int
> > > dcn314_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr,
> > >    uint32_t result;
> > >
> > >    result =3D dcn314_smu_wait_for_response(clk_mgr, 10, 200000);
> > > - ASSERT(result =3D=3D VBIOSSMC_Result_OK);
> >
> > Does this flow actually happen still?  I thought the assertion should h=
ave
> > gone away as a result of 83293f7f3d15fc56e86bd5067a2c88b6b233ac3a.
> >
> Happens or not, we don't  assert here on other asics.
> I don't try to fix any bugs with this patch, just align the dcn314 loggin=
g/bug
> reporting  with other asics.

Got it thanks.

>
> > Maybe we want to also undo the REG_WRITE() call there if pulling this i=
n.
> >
> > >
> > > - smu_print("SMU response after wait: %d\n", result);
> > > + if (result !=3D VBIOSSMC_Result_OK)
> > > +         smu_print("SMU Response was not OK. SMU response after
> > > wait received is: %d\n",
> > > +                         result);
> > >
> > >    if (result =3D=3D VBIOSSMC_Status_BUSY)
> > >            return -1;
> >
> > I think what is missing to clean up recent asserts is actually a little=
 bit further
> > in the code than this.  It should be part of the error flow introduced =
by
> > 03ad3093c7c069d6ab4403730009ebafeea9ee37
>
> 03ad3093c7c069d6a is for dcn3.1 initially.
> If there's an issue with it (which I didn't experience) it should be addr=
essed
> on all dcn3x, that reuse it,  in a  separate patch.

OK.

>
>
> >
> > > @@ -216,6 +217,12 @@ int dcn314_smu_set_hard_min_dcfclk(struct
> > > clk_mgr_internal *clk_mgr, int request
> > >                    VBIOSSMC_MSG_SetHardMinDcfclkByFreq,
> > >                    khz_to_mhz_ceil(requested_dcfclk_khz));
> > >
> > > +#ifdef DBG
> > > + smu_print("actual_dcfclk_set_mhz %d is set to : %d\n",
> > > +                 actual_dcfclk_set_mhz,
> > > +                 actual_dcfclk_set_mhz * 1000);
> > > +#endif
> > > +
> > >    return actual_dcfclk_set_mhz * 1000;  }
> > >
> > > --
> > > 2.17.1
>
> Thanks,
> Roman


--_000_BL1PR12MB517645F3598076AB110ADD1CFD049BL1PR12MB5176namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"#954F72" style=3D"word-wrap:bre=
ak-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Reviewed-by: Saaem Rizvi &lt;SyedSaaem.Rizvi@amd.com=
&gt;</p>
<div style=3D"mso-element:para-border-div;border:none;border-top:solid #E1E=
1E1 1.0pt;padding:3.0pt 0in 0in 0in">
<p class=3D"MsoNormal" style=3D"border:none;padding:0in"><b>From: </b><a hr=
ef=3D"mailto:Mario.Limonciello@amd.com">Limonciello, Mario</a><br>
<b>Sent: </b>Tuesday, November 15, 2022 1:02 PM<br>
<b>To: </b><a href=3D"mailto:Roman.Li@amd.com">Li, Roman</a>; <a href=3D"ma=
ilto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a>; <a href=3D"mailto:Alexander.Deucher@amd.=
com">Deucher, Alexander</a>;
<a href=3D"mailto:Harry.Wentland@amd.com">Wentland, Harry</a>; <a href=3D"m=
ailto:SyedSaaem.Rizvi@amd.com">
Rizvi, Saaem</a><br>
<b>Subject: </b>RE: [PATCH] drm/amd/display: Align dcn314_smu logging with =
other DCNs</p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">[Public]<br>
<br>
<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Li, Roman &lt;Roman.Li@amd.com&gt;<br>
&gt; Sent: Tuesday, November 15, 2022 11:52<br>
&gt; To: Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;; amd-<br>
&gt; gfx@lists.freedesktop.org; Deucher, Alexander<br>
&gt; &lt;Alexander.Deucher@amd.com&gt;; Wentland, Harry<br>
&gt; &lt;Harry.Wentland@amd.com&gt;; Rizvi, Saaem &lt;SyedSaaem.Rizvi@amd.c=
om&gt;<br>
&gt; Subject: RE: [PATCH] drm/amd/display: Align dcn314_smu logging with ot=
her<br>
&gt; DCNs<br>
&gt; <br>
&gt; Hi Mario,<br>
&gt; <br>
&gt; Thanks for your comments.<br>
&gt; I replied&nbsp; inline.<br>
&gt; <br>
&gt; &gt; -----Original Message-----<br>
&gt; &gt; From: Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;<br>
&gt; &gt; Sent: Monday, November 14, 2022 4:16 PM<br>
&gt; &gt; To: Li, Roman &lt;Roman.Li@amd.com&gt;; amd-gfx@lists.freedesktop=
.org;<br>
&gt; &gt; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Wentland, H=
arry<br>
&gt; &gt; &lt;Harry.Wentland@amd.com&gt;; Rizvi, Saaem &lt;SyedSaaem.Rizvi@=
amd.com&gt;<br>
&gt; &gt; Cc: Li, Roman &lt;Roman.Li@amd.com&gt;<br>
&gt; &gt; Subject: RE: [PATCH] drm/amd/display: Align dcn314_smu logging wi=
th<br>
&gt; other<br>
&gt; &gt; DCNs<br>
&gt; &gt;<br>
&gt; &gt; [Public]<br>
&gt; &gt;<br>
&gt; &gt; Conceptually makes sense to me, but please see below comments:<br=
>
&gt; &gt;<br>
&gt; &gt; &gt; -----Original Message-----<br>
&gt; &gt; &gt; From: Roman.Li@amd.com &lt;Roman.Li@amd.com&gt;<br>
&gt; &gt; &gt; Sent: Monday, November 14, 2022 15:07<br>
&gt; &gt; &gt; To: amd-gfx@lists.freedesktop.org; Deucher, Alexander<br>
&gt; &gt; &gt; &lt;Alexander.Deucher@amd.com&gt;; Wentland, Harry<br>
&gt; &gt; &lt;Harry.Wentland@amd.com&gt;;<br>
&gt; &gt; &gt; Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;; Rizvi,=
 Saaem<br>
&gt; &gt; &gt; &lt;SyedSaaem.Rizvi@amd.com&gt;<br>
&gt; &gt; &gt; Cc: Li, Roman &lt;Roman.Li@amd.com&gt;<br>
&gt; &gt; &gt; Subject: [PATCH] drm/amd/display: Align dcn314_smu logging w=
ith other<br>
&gt; &gt; &gt; DCNs<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; From: Roman Li &lt;roman.li@amd.com&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; [Why]<br>
&gt; &gt; &gt; Assert on non-OK response from SMU is unnecessary.<br>
&gt; &gt; &gt; It was replaced with respective log message on other asics i=
n the past<br>
&gt; &gt; &gt; with commit:<br>
&gt; &gt; &gt; &quot;drm/amd/display: Removing assert statements for Linux&=
quot;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; [How]<br>
&gt; &gt; &gt; Remove asert and add dbg logging as on other DCNs.<br>
&gt; <br>
&gt; I will fix &quot;assert&quot; spelling before merging.<br>
&gt; <br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; CC: Saaem Rizvi &lt;SyedSaaem.Rizvi@amd.com&gt;<br>
&gt; &gt; &gt; Signed-off-by: Roman Li &lt;roman.li@amd.com&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;&nbsp; .../drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c&nbs=
p;&nbsp;&nbsp; | 11<br>
&gt; +++++++++-<br>
&gt; &gt; -<br>
&gt; &gt; &gt;&nbsp; 1 file changed, 9 insertions(+), 2 deletions(-)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git<br>
&gt; &gt; &gt; a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c=
<br>
&gt; &gt; &gt; b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c=
<br>
&gt; &gt; &gt; index ef0795b14a1f..2db595672a46 100644<br>
&gt; &gt; &gt; --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_s=
mu.c<br>
&gt; &gt; &gt; +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_s=
mu.c<br>
&gt; &gt; &gt; @@ -123,9 +123,10 @@ static int<br>
&gt; &gt; &gt; dcn314_smu_send_msg_with_param(struct clk_mgr_internal *clk_=
mgr,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp; uint32_t result;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp; result =3D dcn314_smu_wait_for_response(cl=
k_mgr, 10, 200000);<br>
&gt; &gt; &gt; - ASSERT(result =3D=3D VBIOSSMC_Result_OK);<br>
&gt; &gt;<br>
&gt; &gt; Does this flow actually happen still?&nbsp; I thought the asserti=
on should have<br>
&gt; &gt; gone away as a result of 83293f7f3d15fc56e86bd5067a2c88b6b233ac3a=
.<br>
&gt; &gt;<br>
&gt; Happens or not, we don't&nbsp; assert here on other asics.<br>
&gt; I don't try to fix any bugs with this patch, just align the dcn314 log=
ging/bug<br>
&gt; reporting&nbsp; with other asics.<br>
<br>
Got it thanks.<br>
<br>
&gt; <br>
&gt; &gt; Maybe we want to also undo the REG_WRITE() call there if pulling =
this in.<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; - smu_print(&quot;SMU response after wait: %d\n&quot;, resul=
t);<br>
&gt; &gt; &gt; + if (result !=3D VBIOSSMC_Result_OK)<br>
&gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_print(=
&quot;SMU Response was not OK. SMU response after<br>
&gt; &gt; &gt; wait received is: %d\n&quot;,<br>
&gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; result);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp; if (result =3D=3D VBIOSSMC_Status_BUSY)<br=
>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; return -1;<br>
&gt; &gt;<br>
&gt; &gt; I think what is missing to clean up recent asserts is actually a =
little bit further<br>
&gt; &gt; in the code than this.&nbsp; It should be part of the error flow =
introduced by<br>
&gt; &gt; 03ad3093c7c069d6ab4403730009ebafeea9ee37<br>
&gt; <br>
&gt; 03ad3093c7c069d6a is for dcn3.1 initially.<br>
&gt; If there's an issue with it (which I didn't experience) it should be a=
ddressed<br>
&gt; on all dcn3x, that reuse it,&nbsp; in a&nbsp; separate patch.<br>
<br>
OK.<br>
<br>
&gt; <br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; &gt; @@ -216,6 +217,12 @@ int dcn314_smu_set_hard_min_dcfclk(stru=
ct<br>
&gt; &gt; &gt; clk_mgr_internal *clk_mgr, int request<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VBIOSSMC_MSG_SetHardM=
inDcfclkByFreq,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; khz_to_mhz_ceil(reque=
sted_dcfclk_khz));<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +#ifdef DBG<br>
&gt; &gt; &gt; + smu_print(&quot;actual_dcfclk_set_mhz %d is set to : %d\n&=
quot;,<br>
&gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; actual_dcfclk_set_mhz,<br>
&gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; actual_dcfclk_set_mhz * 1000);<br>
&gt; &gt; &gt; +#endif<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp; return actual_dcfclk_set_mhz * 1000;&nbsp;=
 }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; --<br>
&gt; &gt; &gt; 2.17.1<br>
&gt; <br>
&gt; Thanks,<br>
&gt; Roman<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB517645F3598076AB110ADD1CFD049BL1PR12MB5176namp_--
