Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E45BC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Mar 2022 18:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 088C710E201;
	Fri, 25 Mar 2022 18:48:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8460A10E201
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Mar 2022 18:47:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUBEcTAuYTgvG7s9oAIomC7we+6eM5oQ326DNVRpgvzy3I/PBVvGkX/M9uPx8wMfQp2ynICBBwnmG4uGheZTGg0kVf8mavbweTXAAFPr0TCwyNR1mJcE8pG0vn3btYqLMCTYOAP6Tg5XF+2wKNo/q+pvqDdBUtHUsgqbRgVLtHB7YjQokOc09NBXwB1mcN7x7Yq6B6cA1Hi0oNwHg2q4GzvYO6pH3oTlKTjfPYq/NhLHs5jtLNLDomz9hdnhtc+Illl4Mn3zprtACHGzLTqWqrI67aAJEQE4xhpOLJbz783WzrdADUMcO9WYJBIyCETQPL5fzOM019NlTcMYAnhCeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEhLIfxn7cNWpwZjOcxGMhwvCWoUyIynziY/XMdqsTQ=;
 b=dortOW6qld2Cyz/rj5tsyDmSPw6ua2svbeN08ZB2gKRUtRfSQrzghMCCcOqcCFV4B/KPQ6C4adHKxfGxO/SPGufkl0Eg6SGyNqv6xx5O3EopHvRhwwVez/18rCBMzv4A/aa4mibyJuhbFA70OOCowd3wLCbQDhTCmso+9GrM2FdZf7GLYZiOgJEcVM42LcQNUaPt/pMDdmAhjxkhlvwLmLrjV+ckDhkG14TVR98Cq/8MmstdnGSEQI+ih2X0EG7PVtVn/PLhB76MLF+G/1202LfLgac317VKwvcNgUyol2Km8ltyDtqLKUkRc6f6aXWzBPaFV0oGnidmOWi9i4ABMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEhLIfxn7cNWpwZjOcxGMhwvCWoUyIynziY/XMdqsTQ=;
 b=uUzUpru0dn0/O9LoJSxpdsiW5zw0kF+4D72A/YxWJTsiNybWf49uNkXobxHmxJ2FuerzR7lZkQuUbkefKM7h9r8przatvRlfwsVV60443+ftwiRPGGd6pfCQ6PfgHu3oq2lVQeZjvvWkMjja1JLlXDbRDd+sITAj0FmtmpK6MEM=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM8PR12MB5464.namprd12.prod.outlook.com (2603:10b6:8:3d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Fri, 25 Mar
 2022 18:47:56 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::d980:5095:bef2:a7d2]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::d980:5095:bef2:a7d2%7]) with mapi id 15.20.5102.016; Fri, 25 Mar 2022
 18:47:56 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, Benjamin Marty
 <info@benjaminmarty.ch>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>
Subject: RE: [PATCH] drm/amdgpu/display: change pipe policy for DCN 2.1
Thread-Topic: [PATCH] drm/amdgpu/display: change pipe policy for DCN 2.1
Thread-Index: AQHYPvu+k0LBCIQbvUOZaidsTzY4uazQaXYAgAAJ0XA=
Date: Fri, 25 Mar 2022 18:47:56 +0000
Message-ID: <DM6PR12MB352962EAD8E5C0002B6030409C1A9@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20220323211801.1569848-1-info@benjaminmarty.ch>
 <CADnq5_Pr=FvJoqeLoyx7A6pr_fr9NZi9e8BfgrnVeVLt_BSbFw@mail.gmail.com>
In-Reply-To: <CADnq5_Pr=FvJoqeLoyx7A6pr_fr9NZi9e8BfgrnVeVLt_BSbFw@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-25T18:47:10Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=bb188b8e-6473-4e3a-8708-22ba92607c4f;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-25T18:47:54Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 22a7d3a9-f04e-4cd4-8ce5-b11b7136efe2
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ab1317c-f0bf-47b7-2b49-08da0e8ffa29
x-ms-traffictypediagnostic: DM8PR12MB5464:EE_
x-microsoft-antispam-prvs: <DM8PR12MB5464B7A72B6F25A51EE83C229C1A9@DM8PR12MB5464.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7hxFzIKC6aGpHH1fHAAUB8MDCvuVjSEcSe5le9us49KDLcj33G6x7MdkfvSniE68q317fTbFFRlznoNYv0nS/tsivtJEWihAfdtnuMbK5s4pdEwTcmRfV9pRGGuajWQfO1R9vKF6qBoXzdhwh5bvlit3bSx81L9/atCT64zgbh7YHg/EPqjKw7w3tqUfPgZDDTF5iW87wKkdltB+lnpycLEsY8KzZ8X2RPrBTYzao1te6kK1hSnPUtK/V4xgEz2KWOfCDZ0n+FfgwxTphFEGiveUIdpFvvAKCC4msJdGg2YWs8EWxAJq+kTXbd8D0A1ZUTHutuk+d8HpvPLqFQDjy+K3AJnj2xFQMBOf09Jqt4TJo8xfLmu/0xB5y5zFPGNOpncXTk12+NljJx9TXjX4ixeVqEe/HOKbivXuTe7WBtm8pVCncQddlhgXyjdaaWvvBbsIn56AtPmBCiy+W3pnk39zqFvuGn9ndTkWbA28Rr71MRfk+9CKcUIRrvabPlh1Twyul/pjy3SNAunFQibWshju6+tdJaoPsPx/B3iN1j4ysJ8Cy7Y4xN7h9x9LDFExsJhjz+Vv69GxXmXuuRrx6HQ22sEwXHb1cz8iWShp593BhVyD8suymlEYVoSrsycCG7X9Z5NE8Wkdwo1sqiAEOsN3kQ9L8ASW0cK+Urc0qo2h4WupvVJFsgFnHYGaTt3Aw12nLSNw3praRiWTqLtqas5tEtyPQGyNS9Hz2FpFRRsZMg5XYuHnD1nU1uB/I5uS9Br8AfYhVyu/5yLRv3gdtGeNmqv/E5mE9hJZdKZUD7A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(8676002)(64756008)(45080400002)(9686003)(7696005)(53546011)(38100700002)(6506007)(6636002)(110136005)(86362001)(316002)(966005)(71200400001)(186003)(66476007)(122000001)(66446008)(508600001)(26005)(2906002)(76116006)(66946007)(4326008)(33656002)(38070700005)(52536014)(5660300002)(8936002)(66556008)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BdTfXeYrgCw6fIo8akbUCNHXV1jBRKSTp5ZOyxzcr9kjuor7O7+D2sBmYM?=
 =?iso-8859-1?Q?Ej0uwta9RMC7BZwarEzYXd1CMqfh8DTaamCRydqZrlsHQAJjqKH1AllVRR?=
 =?iso-8859-1?Q?SCgQFkLEWiFqtdgS908eu16GSQzH/hEwkRtCOxFKdxcY67ul2x79KYldga?=
 =?iso-8859-1?Q?h2fAArj2a3JwzRIHsG4rQ7hOy6Iq0elq4v0YBDIZccldTmkJfLltjSdn99?=
 =?iso-8859-1?Q?bRFa3iJfVjJsKEQ3rsjJpKSvvoIfz9mu+CCjFVXXZPF1LduNm48UtCkDsG?=
 =?iso-8859-1?Q?gcsk85PrIFJqWSS6iDYSLJjeSawZ2nuaeljyByuhHIl1xacsorAYPFTzAC?=
 =?iso-8859-1?Q?ZhVmDKWgdgi8gkCf3qgDUOl5UzYDBU030113sbYOVgPd1Bl3b1KQven79R?=
 =?iso-8859-1?Q?z6ETQ/LlzxZRouwEyBJ4i6UC+kJkNS4e+zPa9MmyE02n4K/MSXnNlg5wZ7?=
 =?iso-8859-1?Q?Jgxui1thl/k8D3hKhU5+hZvPp98SDjt2+DluMhYKxCiQXVuKsrpQH0ZGQ7?=
 =?iso-8859-1?Q?CVSmeBghW70ug/tdVWIK0G3cV9iThOXMbb5GxWSrCNUnczzkunIRFWcyVx?=
 =?iso-8859-1?Q?D6rJbibhP/Ehjuc4HS5BpuHOup3qQMczIdCJHI64lrVlgitxb9MU4o9rqH?=
 =?iso-8859-1?Q?h0ilvG5idyboqSth5Ii/ZVFw7DOecXi4tvt5BB8zjN0meHFQwqgCzFZgQG?=
 =?iso-8859-1?Q?OSrwNmevY0fRF3c89kHrfqRpScBTSOcZ1F8aKxJbDZLn2GmqZBau70C/2C?=
 =?iso-8859-1?Q?J+N29bibHb7+ld+iy2rD8Zd24dSIiD+OArzKa1CyCNnSXuCJttdkv3KtgF?=
 =?iso-8859-1?Q?27gD3I6k0cLnyF6XhWkjtVkZd7uZdpXbCAZeMj97CoXcc36FYfRwy07Rhq?=
 =?iso-8859-1?Q?hzOzg7P+L8WuxXimwrGpyaTTxQCXelTmBGgkWdg8kaKgluYmGs7DwI4Vtw?=
 =?iso-8859-1?Q?C4E/xE72TTWCkLKpXSSs/tgH+6j48gI3bUU7i+pClQaTe5ZZUEBW2U+0bW?=
 =?iso-8859-1?Q?/5bGVP7zwVPRDOpqf1OAgXh2iBs+U0NzrfEWpxKNfv7A/Ggvwy7e95Al/f?=
 =?iso-8859-1?Q?APhfwfhRBZjcz7yEPWcBjEvgEq6ShvPRcw6atp+d8QyNIfmxNDvP408ie/?=
 =?iso-8859-1?Q?6ePqlQRmewrnu7noyOYrPA0GLHyhdjd0xTt6gj29jsUr4t088Gw8yyvLpM?=
 =?iso-8859-1?Q?ZYwAA1n/EEhW0uqiDFDt0zK0NQah9VfkmDuLnACa1EpnUYTQHcMOVM98aa?=
 =?iso-8859-1?Q?6Vwv97SO1AhW49euye+/3kcRPA+UPwvQOWrnKy8KfwGTsOr2ORjdZf0xwc?=
 =?iso-8859-1?Q?UKhJJg2sOViiQj2tqWzjvwlj6DQ6VkJPr3MXjQ0o1R584ItyEGhzMoUunO?=
 =?iso-8859-1?Q?ivaGwca+bBSUJHB9vsK/tTWdHNvIcB4XnTcGIlcCo2Em9siQTaaGgZK0rN?=
 =?iso-8859-1?Q?sgXh2Izfe0iCOyYNktVBN7qH/6L/fRWM3vktMUe2WiDA14hjh69BuBu+/i?=
 =?iso-8859-1?Q?hOeO0Rb9CMphj5FWcIoaQq?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab1317c-f0bf-47b7-2b49-08da0e8ffa29
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 18:47:56.5992 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m36ldJsLTRyCCaGMLkY34tZyHygc0yh31QDbJdy6WCD2LcBwwYwIISNM27mxn1Yu+LJSXZIONMtb/dEbgtwIHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5464
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

I never saw the hang with my testing, not sure if anyone else happened to s=
ee it. I'm not opposed to including the line.

Thank you,

Dan Wheeler
Technologist=A0=A0|=A0=A0AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook=A0|=A0=A0Twitter=A0|=A0=A0amd.com=A0=A0


-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com>=20
Sent: March 25, 2022 2:11 PM
To: Benjamin Marty <info@benjaminmarty.ch>; Siqueira, Rodrigo <Rodrigo.Siqu=
eira@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/display: change pipe policy for DCN 2.1

@Wheeler, Daniel
 @Siqueira, Rodrigo were you able to repro this?  Any ideas?  Any downsides=
 to picking this up for now?

Alex

On Wed, Mar 23, 2022 at 5:18 PM Benjamin Marty <info@benjaminmarty.ch> wrot=
e:
>
> Fixes crash on MST Hub disconnect.
>
> Bug:=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitl
> ab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1849&amp;data=3D04%7C01%7C
> Daniel.Wheeler%40amd.com%7C21ed4881f6604db48b0208da0e8ae079%7C3dd8961f
> e4884e608e11a82d994e183d%7C0%7C0%7C637838286884708200%7CUnknown%7CTWFp
> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn
> 0%3D%7C3000&amp;sdata=3D9cpmXVrAtmDeAe2VMzcgT7%2B%2BYwmwEOb40fLuY7%2F5dJ
> o%3D&amp;reserved=3D0
> Fixes: ee2698cf79cc ("drm/amd/display: Changed pipe split policy to=20
> allow for multi-display pipe split")
> Signed-off-by: Benjamin Marty <info@benjaminmarty.ch>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c=20
> b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> index e5cc6bf45743..ca1bbc942fd4 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> @@ -873,7 +873,7 @@ static const struct dc_debug_options debug_defaults_d=
rv =3D {
>                 .clock_trace =3D true,
>                 .disable_pplib_clock_request =3D true,
>                 .min_disp_clk_khz =3D 100000,
> -               .pipe_split_policy =3D MPC_SPLIT_DYNAMIC,
> +               .pipe_split_policy =3D MPC_SPLIT_AVOID_MULT_DISP,
>                 .force_single_disp_pipe_split =3D false,
>                 .disable_dcc =3D DCC_ENABLE,
>                 .vsr_support =3D true,
> --
> 2.35.1
>
