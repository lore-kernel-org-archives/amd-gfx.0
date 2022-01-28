Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C41C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 03:00:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA16910E894;
	Fri, 28 Jan 2022 03:00:20 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94FB510E894
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 03:00:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=majNKFTIMeKEInc0wH1BSlyaQNUqIsY9pnY+clEfrTSWAPnA4KyHZooqgSPwKWHH6hf/8Mc6Zh4ZSKfzpwGXC3IgRIYLL22BewZTdlewJsPHpkjRLbOwG4BjxqVZIArMepPJbbkBsHHqLtVKVlarr+b6Mnj/hu8qFHi28AWeoc8W73gCwAomeTS+SGc72oQkk0gdSoThGsxRD+GBv083UFxa/4kTr7SOTmz5pQB+MmZ0g/M171jyVfx8WocZzKHGMYjobNeT2pIu5sgnTaN1TrE2bezs4fiw4K0+Tqr4Wsg0zyKMJW6Sb9h2Wts6tWsRSg+tpPTTo6mbm1E4+YZflw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7J/jDHiR42U48EV97B7c4/Ihj8FDov9Z7kffmCtwg+w=;
 b=TnsiJBPvX8VCjLwpgcBZPa5qXqv0lHJnRn1iMod36v6VHr37tsVoiKCk1OgJhxABnW1kVFecNpc3xwNxg6CfoYkU1LQNyKpTU9O+BUmYPMdOzBWr9dLm6P291gu+QvMFfOgKj/nFaOR7p/Ct2xN+UK1sv9WvZj8kXc8OQZdIlJEli93ljhub293AQVUPHCLnvRmyp8IVuU88vuNXafR3oRu7M5BoabGYfAwfq8BFcAnEyIstrNUfT2aL8TQS/TkLWmzHnHWbJ2wHd2oExa7x+IUfuV1jdi4u8AO8mZnhDpZcy5JiSii5TvmtmETwLUAOMw53xOJT4pm8kxUoHOuTsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7J/jDHiR42U48EV97B7c4/Ihj8FDov9Z7kffmCtwg+w=;
 b=S4FpV5/bXcRcIvl3micX18Q7N4a3rLGKgEoXxb4RB8eFawa0CuKWTMoo1t5B7X9FCAIFp2DQtTLM2RG6g1jJlMK2oXc20kbBoG31SV+wQQZNIIAXw5BwQDDNh8yIMftc3ikKflUTtfxVdnEk3Kl1l+JpYm6A0jRT6ZGYkRUALpM=
Received: from DM4PR12MB5214.namprd12.prod.outlook.com (2603:10b6:5:395::22)
 by BN8PR12MB2931.namprd12.prod.outlook.com (2603:10b6:408:6d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Fri, 28 Jan
 2022 03:00:14 +0000
Received: from DM4PR12MB5214.namprd12.prod.outlook.com
 ([fe80::cc07:fecf:c07d:403b]) by DM4PR12MB5214.namprd12.prod.outlook.com
 ([fe80::cc07:fecf:c07d:403b%4]) with mapi id 15.20.4930.017; Fri, 28 Jan 2022
 03:00:14 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: "'amd-gfx@lists.freedesktop.org'" <amd-gfx@lists.freedesktop.org>, "Liu,
 Charlene" <Charlene.Liu@amd.com>
Subject: RE: [PATCH] drm/amd/display: Keep eDP Vdd on when eDP stream is
 already
Thread-Topic: [PATCH] drm/amd/display: Keep eDP Vdd on when eDP stream is
 already
Thread-Index: AdgT8XWfBXjrFHKiTZam0fg5m5OR6AAAUGdw
Date: Fri, 28 Jan 2022 03:00:14 +0000
Message-ID: <DM4PR12MB521489AEC94BF1A5FFE5331F9E229@DM4PR12MB5214.namprd12.prod.outlook.com>
References: <DM4PR12MB521498A5B7AC85E8BDD6B5269E229@DM4PR12MB5214.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB521498A5B7AC85E8BDD6B5269E229@DM4PR12MB5214.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=f7fcb149-88cf-4290-a4c5-c00e19c92901;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-28T02:49:55Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 935073d0-a7f6-4aba-443c-08d9e20a4e73
x-ms-traffictypediagnostic: BN8PR12MB2931:EE_
x-microsoft-antispam-prvs: <BN8PR12MB29317BFC2BA8CF1157F243139E229@BN8PR12MB2931.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VKHk5DWTRNqAv9u1hzc/9I4IvN1e7ib1Lqlrfqc0cLCu/jnoonwCN69UzaN4+5Ne87DP2NHSoshBpFtsclfgADdS31IL3GOona4d9kh19he+RbufgT2WNu+cHcrGGpDH1cv7Ys9QYiXrBpD5Oh7U6u37TlftveeSzeDOaGGWqr9Uo6QUOHRCwR6ZgxXh9XRjWg2h6BfP5sFsPEaz4SvL6zEeCv6FE6M7VfY5W06AaSHy27Yqq5IRrK9HiBAimnpiTvjzEw1fp45zCC6+y5k6gwfyDozMy8JWpkgBPEFt/N4tL+7HvkTQr2duqXODqPO8Ly44XNRn9RyVqik/ly3x3oEq3PvVd9RLRqMYgsQVQ9dLCTNGV3WXlJ7HYbEBlHXifgU7Hnatp3GWGcqk7g/HSBvvuuP6s8/aQBGv/V8pHx6ipd0Szj+oMRnvv5WxHT0rfFCpVwA58sdbY0Lyola1LbsKVR8AlHmWOxPDguD/qzSfZ/AAfJ0w2/2eJvKfR+1WOLve+HjEgw3hD8hnc6Oq1dy5TE0HTv9DLwtD7951hIPPc4mNQMtC1jJnv/xN7K9F2/dWzqf1RD/d6EqndDgUqtymiFEnQntupIuWu8buPdOphzTDV4i/GvFazxO71rRd+1a+LARinBXad6htbpPDLc4H3h+zoxwpHUxtrjebUzweq3FtpXkKfuQAjFAZKhytwyoTX2Q436dgd241V2Eee/6VxW4qYEAYTtCHS1wl37g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5214.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(55016003)(71200400001)(2906002)(86362001)(83380400001)(122000001)(38070700005)(54906003)(8676002)(4326008)(8936002)(26005)(2940100002)(186003)(110136005)(6506007)(9686003)(508600001)(6636002)(53546011)(316002)(52536014)(7696005)(76116006)(66946007)(66556008)(66476007)(66446008)(33656002)(64756008)(5660300002)(491001)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?syy9NO43QL+lfhyVq2Uvyu2QfDRkh43snUv1AHVTBzTajiU7xTzJQ7eWPamT?=
 =?us-ascii?Q?NySU9SIS2DbI/WkFlV1DBZqvK+TXS04QGqKwQOEEdH2KoJZ5R2E5JjFO+ecC?=
 =?us-ascii?Q?DXHCx48+WMFFk7HLyx3H1HAP90pe2L2CbCfF7+gf+CLiFm9Sht3CJqlA6p7J?=
 =?us-ascii?Q?lIJxx4pQrKBJWvvBKkBlcE1FWuicByNVPL2Nj/XVUl3sAVWKkxpitOnkz94d?=
 =?us-ascii?Q?gii6tLro5OiNVKpjncqiadYtZTjl6D9uE+sILxeJ3YvUTYyx1d0BcU7zIETV?=
 =?us-ascii?Q?bBoIx6m+kIWQfXuhuo46OFY5EdQQVjcdrQJmTIiW0me9eNCyHnRvd210OENu?=
 =?us-ascii?Q?6OcD+a/Ludv0gTuK5svJgPr107PjXeeU15qQxFJA9cOBF3Mu3yMGpfeyFSbb?=
 =?us-ascii?Q?y7PAlF8MVH7Z94wENELPcXRTjSwjZZk/BnMSnLzQZXrC4JDTfgOh61hGvJYe?=
 =?us-ascii?Q?T9T1wXMSlm+bxLrgRNj3K2PgjFgwVSfMxPv1OUathKlg50GAsDorfo+Yrq9Q?=
 =?us-ascii?Q?lh4gNQjxhmHoucPUZCnhvDNk6w2sObXvFkIubVGMlcONLFc4k/VoQsbf6JQ+?=
 =?us-ascii?Q?V9YokCsfRB6mgEC+bCzAwtuse7FsgkXStnN2mmfW6p78QmmwsBFxgaCsE+yt?=
 =?us-ascii?Q?7tVwkKNmm6BSoLUFJrgrShae7KmbR0Qw/0V6pvlTuT04lV9xv/ceNmSfn8uq?=
 =?us-ascii?Q?9Q40pB5uouoTmL13DdyijizYGB928v40UavnpHKvVXSniw6+d76wjsMtEyBQ?=
 =?us-ascii?Q?HDSWf5X6LShBCxoUnzePABhfjJJ9Rj87pMDrTdFl6FriObSMhB3DC194Yjjb?=
 =?us-ascii?Q?+2ZIRdlKrQ4Ec/aoRYSnEOlM7A6iNufTDPKvfLpm8zJRYKrebiONb86piV+u?=
 =?us-ascii?Q?wo8RCjOt+Fxu1F8JsTaqY0ATyBh4B+Lo0n/kB+FBwFFjSqLNKcf65WA3/gi3?=
 =?us-ascii?Q?iT1gUpcMRltLGwutPnnDIN8PPRuDM1Uu1mOplY4E4zQvunhIrmSKzvEJI1M3?=
 =?us-ascii?Q?AUVFqhcLLeC1l4WklBGcXzvn7aHOFJx/BkIjTeqlyGJEOrBa9uTZUiMavY0W?=
 =?us-ascii?Q?W8ChXVhvDcrzBWP8UDQzRVLeVEeRArDijJl14GIN9DdaN4Yvvc+bTJt9+DTw?=
 =?us-ascii?Q?wfMOX9SBucMx26V3HFefJmadx2u8xrRpYhHIHebNXO9HT36I+RtvoH6WxZE1?=
 =?us-ascii?Q?XuXTdPRa/7Tg1tNCp/eQZJuQ6B/MXDjh9Urtuz9K0pJm+wD82xlqemQxZ2RW?=
 =?us-ascii?Q?IQyaVYKwJmSpi7kD4Z1WbjNcf+w4Sg67EgT9qbaqPf8OjJWux408d3LSq8ob?=
 =?us-ascii?Q?roV7QctuL//A1RwxzbWvPQFyvToFBAZuzRUvEHJDXPyGfx4AnRYmsg5EWWRf?=
 =?us-ascii?Q?/kXe8gQ9F2oS5xgIzVqJS/2/jdevwn1/KhPXfnZ83GPDB7CBxuco9gcJak8c?=
 =?us-ascii?Q?hqNUUVhsHtoYGZa69pu/uAsWMIiVq6pnJcE7Z5OJdtYenL4AErTDCBU5R0nK?=
 =?us-ascii?Q?Dmv++N2Eoq7coI+NpjPVaXQhbHeKjyJu41zW2fVAkYGfO739EjdJa2oR60bK?=
 =?us-ascii?Q?eggTQ12wHAMYEv96NAk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 935073d0-a7f6-4aba-443c-08d9e20a4e73
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 03:00:14.2568 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: enKhGYkPLYNcVgU2axsq03XUms2geXNimN1z67x6XtrgEO6WGJikXp2m8Z/lLGSE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2931
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
Cc: "Kotarac, Pavle" <Pavle.Kotarac@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>,
 'Pierre-Loup Griffais' <pgriffais@valvesoftware.com>, "Cornij,
 Nikola" <Nikola.Cornij@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

After giving it a second thought, I will apply a similar patch on internal =
branch first, then get it promoted to external branch. This patch is abando=
ned.

Thanks,
Zhan

> -----Original Message-----
> From: Liu, Zhan
> Sent: 2022/January/27, Thursday 9:51 PM
> To: amd-gfx@lists.freedesktop.org; Liu, Charlene <Charlene.Liu@amd.com>
> Cc: Pierre-Loup Griffais <pgriffais@valvesoftware.com>; Cornij, Nikola
> <Nikola.Cornij@amd.com>; Kotarac, Pavle <Pavle.Kotarac@amd.com>; Gutierre=
z,
> Agustin <Agustin.Gutierrez@amd.com>
> Subject: [PATCH] drm/amd/display: Keep eDP Vdd on when eDP stream is alre=
ady
>
> [Why]
> Even if can_apply_edp_fast_boot is set to 1 at boot, this flag will be cl=
eared to 0
> at S3 resume. However, we still need to keep Vdd on at S3 resume. Turning=
 eDP
> Vdd off at resume will result in black screen at S3 resume.
>
> [How]
> Don't turn eDP Vdd off when there is an existing eDP stream. This can ass=
ure eDP
> display come back after S3.
>
> Signed-off-by: Zhan Liu <zhan.liu@amd.com>
> ---
>  .../display/dc/dce110/dce110_hw_sequencer.c   | 23 +++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> index 72dd41e7a7d6..1aa6f2737534 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> @@ -1796,9 +1796,28 @@ void dce110_enable_accelerated_mode(struct dc *dc,
> struct dc_state *context)
>                               break;
>                       }
>               }
> -             // We are trying to enable eDP, don't power down VDD
> -             if (can_apply_edp_fast_boot)
> +
> +             /*
> +              * TO-DO: So far the code logic below only addresses single=
 eDP
> case.
> +              * For dual eDP case, there are a few things that need to b=
e
> +              * implemented first:
> +              *
> +              * 1. Change the fastboot logic above, so eDP link[0 or 1]'=
s
> +              * stream[0 or 1] will all be checked.
> +              *
> +              * 2. Change keep_edp_vdd_on to an array, and maintain
> keep_edp_vdd_on
> +              * for each eDP.
> +              *
> +              * Once above 2 things are completed, we can then change th=
e
> logic below
> +              * correspondingly, so dual eDP case will be fully covered.
> +              */
> +
> +             // We are trying to enable eDP, don't power down VDD if the=
re is
> an existing eDP stream
> +             if ((edp_stream_num =3D 1 && edp_streams[0]) ||
> +can_apply_edp_fast_boot) {
>                       keep_edp_vdd_on =3D true;
> +                     DC_LOG_EVENT_LINK_TRAINING("At least 1 eDP stream i=
s
> already enabled, will keep eDP Vdd on\n");
> +             } else
> +                     DC_LOG_EVENT_LINK_TRAINING("No eDP stream enabled,
> will turn eDP Vdd
> +off\n");
>       }
>
>       // Check seamless boot support
> --
> 2.25.1
