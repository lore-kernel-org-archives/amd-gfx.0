Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27083C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 06:24:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0AE310E538;
	Thu,  5 May 2022 06:24:18 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6033210E538
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 06:24:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mR41bB8YJ4LUngjvFZju1PQFoxJaYFoIBhD6zaGK77KLzCkhS1GfoFjd/UBFnn2emOb7W2pCz/FcKYncVAO++76wwnpOaswrXCA0LDICvStk+5/j55a57FrIho5PZzvg4lTJ111zD+OPg+Es3/4WRvelcbZrAYa8Ai2pY3y0Lzs4vwNcAA7xBLZIlg0j15OkASGuNmuKMcRa1qtJdYkrM8CNkH5PZRs1HzaTho++hSvukImLxxXTcrY16zSa0BMA6SPsupl5eHD9ERnn5PaDVEdodnZnxFonMIANRXyGluUYo4+rbCy0iBr9oGBly4Bui5FFsallOGWCeo4TlMGtOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7fqXF8F+QV8eLUwfS2KucgGzfkTDSYpccHbpoiaoa8=;
 b=MPOyRsSEhU1mHPanHgcb8GzGzcytOwgZjNvXwr8yzp8o/M4N7Q59md20HDD+h1o2/YuzXyHZXmWXMkCLmK3uEaHwZrEdqDce/aXyVEuY3wY+5GoL84ZoCy6rGCEWPo+KwTaao6wx5QcXXg18ve/I2fsbL4PXQAtCbLgF6TkU/VsUMT1tKNHJA/wI87GtjjyG2UVp30+7b/Nfor1AF2UKaPHY5XhfVFjB5a334You6VgghRtYd4mibbKQpICJIo5cDY2/BSfeLQxA8Poa+7txjF0pw2XjoCBsPa0sr4jziscbA6igKy4YjndVDzW/zvlXTrO4CK27m8o72FeZyvQRSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7fqXF8F+QV8eLUwfS2KucgGzfkTDSYpccHbpoiaoa8=;
 b=wCtIi/bUL0Au6XnqeYTf1jWFTcquarEvwsg4Rrb9j4528C/NQasImy42rLAWSu+FtGnss4rrzk/m05Rr1a0DwhUoKknMZSWtvrjB6h7TS2jUDQWMqmn6l37kJ22vXRybYu8fyWitAFrwH7QyoW82cR6zd6ambrxXC04x3XUkNxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.24; Thu, 5 May 2022 06:24:15 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::b846:d865:5901:f76d]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::b846:d865:5901:f76d%7]) with mapi id 15.20.5206.024; Thu, 5 May 2022
 06:24:15 +0000
Date: Thu, 5 May 2022 14:23:55 +0800
From: Huang Rui <ray.huang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: handle asics with 1 SDMA instance
Message-ID: <YnNtezRMTqBmge+D@amd.com>
References: <20220503203834.1230487-1-alexander.deucher@amd.com>
 <fb2286ca-1162-93e0-daf0-6c76f2426efc@amd.com>
 <CADnq5_O5CiO0vW=3s6Uf3HcRnPFRO2RK6KEGbZqjwK_ofqXpjw@mail.gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_O5CiO0vW=3s6Uf3HcRnPFRO2RK6KEGbZqjwK_ofqXpjw@mail.gmail.com>
X-ClientProxiedBy: HK2PR03CA0045.apcprd03.prod.outlook.com
 (2603:1096:202:17::15) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adfe7f88-c83f-4040-ba4d-08da2e5fe06f
X-MS-TrafficTypeDiagnostic: SA0PR12MB4512:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4512C64C32EAB0F8269D4E15ECC29@SA0PR12MB4512.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KOKjL5pxX1ON1MhEJoihDsGmVt6aFiF3Q9aL2nzMcW6bZgu6j0w7/cQacgQ1KMZIakdSFabqfvVbNjb5i9N55PZUMLQDOgXq8rTL0nYMB94Wo6rjxwAHvV9XkUP4np4JYGNwExwS494OEOrZjxPrkZv1GMtZLRHxxwQsCyoXBtKQxZn8k1NvfT6vbMB2bR9LkihqBPmfeyYdcHlvy/pq7yLBAEZVuJM2eSXIRmN4u34QP0ABtbTwoDuch+cJj0qMPcW+PgHTjnwYl14Gb1JWf6e8OS5wL42wCuWtKoMuJf9E+v6T2UK2yYHJMIgP0dJEabuLnx3uLWd3vLsWy9lNu1aXQ31rQBEUyGcbVjkggH5rpqIGjFK4xca4PhHV8PgWRjfNm5R91tOpYOBTlwimV+Fv6lRgFPDu/bdVuA+dc6DfdVJfXO7ONs11GJbHQCP0Q9jbryEc51QJAZiXQoeQrmNw13oFnLx3Pa2oK6gO71Jb0OfjzjcXF7vFjK9rc/pFfmMbhO+w1OI+8k24YoOmAQaSQnQVWV/vIN4zGtcCIPJ/RgHuCvQiQMfy4fif1m5F/uosRoyeDr91C/TXsDs5KmT9k/8e/2bjqEwxG1UGyMk4WRJpFxxXNIdfGbt7kRYTTxx9tqmkbSkbl9PKTOjvCaAZ/oJVxnnsG9UnppT/EwDhoU9YhUpmNhwOO7zO+SN7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2504.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(26005)(6512007)(86362001)(38100700002)(8936002)(66476007)(2906002)(53546011)(6666004)(8676002)(4326008)(5660300002)(66556008)(66946007)(6506007)(316002)(110136005)(83380400001)(54906003)(6636002)(2616005)(36756003)(186003)(6486002)(67856001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?a9KtP6lWgw8oF9rfk8c7+r3eOHn8KxpUfvamyvI2dzjpG3LNXK9Bsu4XOm?=
 =?iso-8859-1?Q?CWuckpE5ae8ckfg6GNTJy/bYJjViRo4c1wHtjeACLk1A20RHoGJh9xZx8Y?=
 =?iso-8859-1?Q?WsX9I+LKFxgurzU6hraV7Iwlm3EdQKQph3zyv/AwyxFGGnTzoRGI9OHOOD?=
 =?iso-8859-1?Q?Ea39rF3j3thsu3XCzKaV2LML//6rDh9GeB1WOrrRNxGKpoiYzlZySxdS2C?=
 =?iso-8859-1?Q?c4WUmvAWVAZyPzGiPAsoXW1P9jMFwdXW91V7z0l59Ts8sBCs+lyRnLKviV?=
 =?iso-8859-1?Q?hCqJmyzyjd5cKIr0ecV0RBT0Avc5sX9ed+KNZs0jMvteXdsLtImynpJez3?=
 =?iso-8859-1?Q?MiqIIDZ5Jdh5gusyCHR6d4d8xBKkPQvBaBj+NbArpSR7lBZp4GoblDP69b?=
 =?iso-8859-1?Q?FQ2SFPCgkWR/WgVN4IBvYK8bEH+EmrO6Tvz6X/bkJSaprs2xhYjVUwbLRW?=
 =?iso-8859-1?Q?1MzmErC8fM6Rn8XQn01ck2gJPeo63vH0CZnWpTceMfMSV/LF679x9rRPIy?=
 =?iso-8859-1?Q?YkEk1ij/LlZ8LPZVbmYad3Z1kzYnwgx5aQFECRrZWl1khQMjbQtT4iyVyr?=
 =?iso-8859-1?Q?YMnVoDW0Zd8XEp1PtvRkalFUBCome/MEKgtPpAGynvguSUUEztosMtwYf/?=
 =?iso-8859-1?Q?h8J1Q1Vyl/UFJPjX/12akahGd03l4985obyb4OT3+6qQ5ArzCdjx9tmSDZ?=
 =?iso-8859-1?Q?8yvOvTY64UpUjXSUUTTI8/JB9By/T+88eS6cwZtbXq52YlZ3h87Z5SoeNT?=
 =?iso-8859-1?Q?Gbf2/ZKjuSeIL+QBXy8LxVWHPTGwZHYQvCe6JkKsbAtdH96TVqed6W7eIR?=
 =?iso-8859-1?Q?JDf/RolwK356jRMSCrWmQFp6fgW0mWu2Jy0Y5fVTSsDYqVOqxsfYSVerYq?=
 =?iso-8859-1?Q?F/8gtK7BTiZqtA47y+PSGXCcpdvK7+Vgp4fRahyE2hg+z3Kbmj2f3tw8kt?=
 =?iso-8859-1?Q?gw//HQ/YG3eomIHNp3jXhsgLEGgJR/7N6r6MXZQU3CD3jjMsDLT+XwOj9a?=
 =?iso-8859-1?Q?e06+uKyehhR6gobTiiaDRT7qFVvl6rmkQcM+LkxN2q4TXXroDPKneNc6OE?=
 =?iso-8859-1?Q?xKCeygI1c9RgMim1kspTeQXGtP9491TicCs7mi304/nO7mxhFCwoo47QU1?=
 =?iso-8859-1?Q?vW7Vjqs7lW0w6+CshfZ+2rEqOd7CI74VVmO9c2Fdaxut3OlUqPmkK/Fj0e?=
 =?iso-8859-1?Q?kRVq1r+98GnipvlXuKoKjnp0RNgq2UBHNx/mrEmNeKlkzcM6DTkN38x+fC?=
 =?iso-8859-1?Q?HbaxJpTnL8HYJokKRG4PLatJROT6xTi0T3q9+ELzUixSXe5eBA8gMLvcXj?=
 =?iso-8859-1?Q?QcZo/P368fz4iAKjugTDWgDce6PX3pysl7DDLeJuPQastM875bZk3nNl/B?=
 =?iso-8859-1?Q?49gAkGpoX3UBA/lnCmCBKaRh5y/p0/OC/boe/r/x/wfsqBewBmGHMpVB4E?=
 =?iso-8859-1?Q?WOdONcf+afkztI187J/ZgSAB+PnchldW1c4fz+VQLNWMURzBv4IyE+z7FU?=
 =?iso-8859-1?Q?0IDA6RLrwmNalRlZ3/ci4BOpEXTJKdlrgpJ9IoSvCsdVeVR6060XyPz0PT?=
 =?iso-8859-1?Q?uLQzwND0AX/c2NaDTivOMEckFR/uSsl8XRTxD9ojVO9zpQpmnsKNQpNfvB?=
 =?iso-8859-1?Q?SdnLy18ubKJjtDlsp7QnzdT+L6Bg5hiXi3xTQfCLU+GwOBcMjW8ZmxXdHe?=
 =?iso-8859-1?Q?OxQfOQQtmnZmYFH1K5slDyx+pNbgXCsWFj5tl6yf8qd+/pba+kpEh/gxKB?=
 =?iso-8859-1?Q?10gJcqznT+4mp/5vVB9ih4heFAgND6x0LzzqzNqBdrAGzM5FPcTNTmZj3D?=
 =?iso-8859-1?Q?7I99/gaMjA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adfe7f88-c83f-4040-ba4d-08da2e5fe06f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 06:24:15.1348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SEa7NtrEoOpr0DX8RQUTHEm0o/mgqc/d6pk9DeJysDnz5hddYU1oawyvU6wKcUIGdXm1RjtVXAVUZ7JPYwFtfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4512
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, May 05, 2022 at 10:52:31AM +0800, Alex Deucher wrote:
> On Wed, May 4, 2022 at 2:28 AM Christian König <christian.koenig@amd.com> wrote:
> >
> > Am 03.05.22 um 22:38 schrieb Alex Deucher:
> > > From: Xiaojian Du <Xiaojian.Du@amd.com>
> > >
> > > This patch will handle asics with 1 SDMA instance.
> > >
> > > Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
> > > Reviewed-by: Huang Rui <ray.huang@amd.com>
> > > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/soc21.c | 5 +++--
> > >   1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> > > index 307a1da13557..29acc5573f56 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> > > @@ -252,8 +252,9 @@ static int soc21_read_register(struct amdgpu_device *adev, u32 se_num,
> > >       *value = 0;
> > >       for (i = 0; i < ARRAY_SIZE(soc21_allowed_read_registers); i++) {
> > >               en = &soc21_allowed_read_registers[i];
> > > -             if (reg_offset !=
> > > -                 (adev->reg_offset[en->hwip][en->inst][en->seg] + en->reg_offset))
> > > +             if ((i == 7 && (adev->sdma.num_instances == 1)) || /* some asics don't have SDMA1 */
> > > +                     reg_offset !=
> > > +                     (adev->reg_offset[en->hwip][en->inst][en->seg] + en->reg_offset))
> >
> > Hui what? Why do we filter out register reads in the low level function?
> 
> It was copied from nv.c.  The proper solution is to handle it like we
> do in soc15.c:
> if (adev->reg_offset[en->hwip][en->inst] &&
>                     reg_offset != (adev->reg_offset[en->hwip][en->inst][en->seg]
>                                         + en->reg_offset))
>                     continue;
> 

The SDMA1_BASE are not contained in GC V11.0.1 APUs, so cannot refer this
pointer. Above check is better than before, thanks!

Thanks,
Ray
