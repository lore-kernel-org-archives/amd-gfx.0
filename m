Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B899C76196
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Apr 2023 06:01:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91CA310E025;
	Mon, 10 Apr 2023 06:01:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::623])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4CF210E013
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Apr 2023 06:01:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ca2KDzxXrazPLXY/leTDdbmMVwPtoganCkdHzJ1mcRq4ydk5jfovkfQp9ft6XDCyZ62MfGiq1YR5oiKe6+ovPHRyEh9NfsSiYGdqNX2lyq0BGxcoBwRgk8O7DfyCv58FWauyta2jPQcDzY0RhAleMXYEk21pD8H9TTnR3xVnU1xGsVkh3hEM0vi6uKnhSAjZKJymSzshEheia9h7zNzUNqEiRvpkzD3jY5fY9eGCjS0EWLCcAigTReBn1dz9IS/SXPndpQn9HFfEDzyd/C3vkFalrU1IieHjNzKuMF3HXCFv+WZPKzqNV2sI+dx/roRvA+6qux5Jj1CBxZJ05ZOWCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngpXics5PdlxXrGvXZA6k+tu8uwWdRpLulN7J7I+EDs=;
 b=Yv2+q40gAZeq9eFVFp16C/CIS/nKsqwPAdEnGPR4AV4Cl1nv6fVbVKqK/3ij/U2z2i6Wp+r5MXimMa2g0IjTcXXDjm06GdKjlci3nvySx5fN+xvNT/UbTA734RDbwjutk5cWnbDp59Jx8KkvC1DzdzvRNv6hhFQTtiM3mP6Kp5/VzdmJVdmIjwsD26yWcGxRgv3Y5mjZ4ytVSQeCCWoXmIDIDKUbze55cC9pTG3MCl6Jq3HcE0ctkFUaXKrZ/TquJcxb4rzZFvPz0PUheoyyM0N9RurAed/tVGxZd5NSXitFLa7HBUPEfcXMrRYHjGZOChP6qxz/3MmLwa6AeRBrtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngpXics5PdlxXrGvXZA6k+tu8uwWdRpLulN7J7I+EDs=;
 b=bdOKyUZzhcXzk7iaH9LKVvcBBpAZOG0Sw8zX9WON8cPEJUoaPGjTxZSqsJVvQBRRNBBpQaMn2w8jmzvqVpVN25KEPV44Co/c3zt5zLvijbPd+QS3qpRtNun26+eBq1KMf8eaziMc642rbuwwpeW9KUWq0O5WbgIo3BGBhxBGTKc=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 CY5PR12MB6249.namprd12.prod.outlook.com (2603:10b6:930:23::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.35; Mon, 10 Apr 2023 06:00:57 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::5ad3:9c0d:b7f:3bd9]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::5ad3:9c0d:b7f:3bd9%6]) with mapi id 15.20.6277.036; Mon, 10 Apr 2023
 06:00:57 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Zhang, Horatio" <Hongkun.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amd/pm: correct SMU13.0.7 pstate profiling clock
 settings
Thread-Topic: [PATCH 1/2] drm/amd/pm: correct SMU13.0.7 pstate profiling clock
 settings
Thread-Index: AQHZa1CtWneCgj5ki0uWMOHQ8QHOSq8kDMHA
Date: Mon, 10 Apr 2023 06:00:56 +0000
Message-ID: <DM4PR12MB51659676A79592FEA6EC29578E959@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20230410020330.66938-1-Hongkun.Zhang@amd.com>
In-Reply-To: <20230410020330.66938-1-Hongkun.Zhang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ab3e1084-c10c-40a7-9032-c55812f54a90;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-10T06:00:03Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|CY5PR12MB6249:EE_
x-ms-office365-filtering-correlation-id: be2e29b4-aa8b-4861-f9bb-08db3988f37c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +LIeXjcHdHLVieJwewPYrmOBUKR6Jk7ve9MqIG/Awidj8d/XHNJLc6qMYdwu0mMwYShY62kFjOqSg4M6D19YCFqu/OuzII1I8ck1HdXb0jeIilJUuRAwu53NBusy9dPaozw+1P911zS4/8pC1A5fcxsb7i5BzAtXwQfWcLBRxzC+19GBqaxf7XMEFBElTujO+t/6l7kSETovVXr3TdKyhpRDVgp9pQjZrJ4MEEgaq7PTdTyfjOGlTdlN0mtDae8cQNDsFEXizdbhyjM0t9LvtN4jxknLGOAbn4/9IuzIgmt6PFqRs+EAHbAVVOFQBXa1cyt9qoe9gkAt6UZNVi2Tih5x36z/jtk0TMMv8MpYR7jhX1+zSUUxvjd/LcCuPtpauktfI+lEFOvOILSUGPdUtOiwCKUfHp0JoevCJ68cmRWk9V6XogClVWrbKYbQSSPJEZFBmQV5j7e4SlrIQHGF8LtEeaTheialXno06VG913k3TGkIOeBX0uRmGFB2d+t8ZCJd2XlGoY7Jr4pzhTAxQ744OSnINMp61AH1N1b754azue1oFoT5zdlYmOAeTLNqZ/X5u+e3hDXMZHp15lIYu/5EGC/80zieHSj5e7AzpGGeaBWXNqurz+VnN+o06Pa2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(451199021)(478600001)(7696005)(71200400001)(316002)(54906003)(110136005)(9686003)(53546011)(6506007)(26005)(186003)(2906002)(5660300002)(4326008)(76116006)(66946007)(41300700001)(66446008)(8936002)(8676002)(66476007)(52536014)(64756008)(66556008)(38070700005)(122000001)(38100700002)(55016003)(86362001)(33656002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YTrukTnscH5lSO3EEFVTjoHgMn2c0yB4hwJ3An8klC0LC3G4ADajwsytbXgy?=
 =?us-ascii?Q?8RqDaKk/osoBsxhynwWbwq4Z2ClHI9wfXxNAkApsiOnPP1VygHwggWwykbhp?=
 =?us-ascii?Q?weXcWrja0cRJGQPYXwVrKjs87MfljTPsS2dtSVSkx5xZ94jOJEine60egZY7?=
 =?us-ascii?Q?cl2W9PsgFcjwvxhYHBtIxLQv+eOVO9wEjlFnckK5ylL1oL18VMQmsdi8hKku?=
 =?us-ascii?Q?I/dhttu9M+IMgIvIudi6aGuthryN+OnY8r2DlGnrLPEjpYleIc5ma2QDJ1mu?=
 =?us-ascii?Q?aETJt8MGmfpInQ191XJKvUJFjwDFL5O3rxZ4C3lO+tT43SQhNDQL2AEmt/Z8?=
 =?us-ascii?Q?UDRdjdtlKVBOLZ5B03vgSgoX4BsB3JHXiI034Qlnj6kaQOhaZ1yePypHZg/L?=
 =?us-ascii?Q?wdaEBHYvrgHRWd4Kd6K5wqn9Ca4xDJgD9IvZ9SZZGOBonU59Xzk486je++ua?=
 =?us-ascii?Q?6VqOEul/gRqJET9Nu/vSZyqxJNfLmAY22mDGIsVv0gXH/PAAmWTMvtnqwNX3?=
 =?us-ascii?Q?UgYrLOB9CplxS9tLhCEE6LtiP1W01/mQuerQ4oFOOL24aE0vsyJ/05XVqdVq?=
 =?us-ascii?Q?1X4bEjlGXDLpycXNRpVLY/3wVPm3dNucA38AFNL7UQBy9jT04WgT6DSYQ8xq?=
 =?us-ascii?Q?TPWkv/B7FNFodGCWcS2ENLUV3RGtKqYaX/pGudiQqlVM2cF2m8DYDCj81K86?=
 =?us-ascii?Q?E9X1KPHdI6D6pjQTYxuRZoKbyNQObZv74RiG7kmpx2dTQocwehwjjghViLJT?=
 =?us-ascii?Q?gfQ0pTUeDOwIPm8C0yAIMmjtjm0b12SKCmD7nI6Riprzg3BM07R4ZNvAwBnB?=
 =?us-ascii?Q?Qq4RvZ+Ndm4TKR0oIBygIyAKJq4CukyFRzCVG89kMBYr2HmvV7kR4spQllCi?=
 =?us-ascii?Q?y4EE8X87hwYVqJGzSBDJcg0Lv2IB3VPKvew6d91EBIvl6IfDBLxzfwDyP7jA?=
 =?us-ascii?Q?k9U9kAnBgMOoWJDhaiTVcY3XmGCALVcgJExGKW66Xfk07cOVXD8dHN4cYyo8?=
 =?us-ascii?Q?yrGBUyCWqWk56AI4cWrbMi31FEhvjjrpujAYuj7FNcvrcppFBxQiGOZGXvGC?=
 =?us-ascii?Q?Wl2xFr5wBzMe2JoP3Zv0PaR9Lx7GNZB49O9P4X/LrhQOg2PcVmNlbN1QBara?=
 =?us-ascii?Q?EwJ1CpKvjzcznGeOshkdGz+zgKrTokVHULvU46kVLjHs7rqoo8/bCSlSxrVV?=
 =?us-ascii?Q?t+q1gBL7JTPRmcbo+oKaPp2IRa6JHSVbrp5fBzxJUw8cS9brR8SqiXvWbU6Y?=
 =?us-ascii?Q?+lWka0I8oCshxKeU7xQNAiEzvNcvVNCYbljwe/EYSTAvqK+wy955ZPXqofOc?=
 =?us-ascii?Q?m1JdnOSBlKz5+k7v7mcD4aLocbMhc1PP3oSJMDIY0TkbrL4UNklG9Y+eKElm?=
 =?us-ascii?Q?pLeUhCG+0ySMsiUWBAwtlLef/zJJbnRHk4SZWbDvuJq70RFowFMRo2Df6lsG?=
 =?us-ascii?Q?5EXpTJFm4lSTw8Qz8TKzU9nMCIC9qGozIf8tKD7DUv3TFuLcubKH0GSZ493K?=
 =?us-ascii?Q?OLRENt9P1PAkID61WWK+Jg923DMh1OCcwNkTpRHaItiVWAFkFeKHiQwpdK+L?=
 =?us-ascii?Q?ccXcVI1NsWuJY75y4q4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be2e29b4-aa8b-4861-f9bb-08db3988f37c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2023 06:00:56.6260 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eNmTH9Ys9O/p6EYGBQEtxHqCIZiCbh45CHmsYWMcxXfqhr1n+9QjrICdIuMR2gCp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6249
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Zhang, Horatio" <Hongkun.Zhang@amd.com>,
 "Quan, Evan" <Evan.Quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Horatio =
Zhang
Sent: Monday, April 10, 2023 10:03 AM
To: amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Zhang, Horatio <Hongkun.Zhang@amd.com>;=
 Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: correct SMU13.0.7 pstate profiling clock s=
ettings

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


Correct the pstate standard/peak profiling mode clock settings for SMU13.0.=
7.

Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 22 +++++++++++++------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index ccdc2ecab1dd..1b1c6c21c002 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1329,9 +1329,17 @@ static int smu_v13_0_7_populate_umd_state_clk(struct=
 smu_context *smu)
                                &dpm_context->dpm_tables.fclk_table;
        struct smu_umd_pstate_table *pstate_table =3D
                                &smu->pstate_table;
+       struct smu_table_context *table_context =3D &smu->smu_table;
+       PPTable_t *pptable =3D table_context->driver_pptable;
+       DriverReportedClocks_t driver_clocks =3D
+               pptable->SkuTable.DriverReportedClocks;

        pstate_table->gfxclk_pstate.min =3D gfx_table->min;
-       pstate_table->gfxclk_pstate.peak =3D gfx_table->max;
+       if (driver_clocks.GameClockAc &&
+               (driver_clocks.GameClockAc < gfx_table->max))
+               pstate_table->gfxclk_pstate.peak =3D driver_clocks.GameCloc=
kAc;
+       else
+               pstate_table->gfxclk_pstate.peak =3D gfx_table->max;

        pstate_table->uclk_pstate.min =3D mem_table->min;
        pstate_table->uclk_pstate.peak =3D mem_table->max; @@ -1348,12 +135=
6,12 @@ static int smu_v13_0_7_populate_umd_state_clk(struct smu_context *s=
mu)
        pstate_table->fclk_pstate.min =3D fclk_table->min;
        pstate_table->fclk_pstate.peak =3D fclk_table->max;

-       /*
-        * For now, just use the mininum clock frequency.
-        * TODO: update them when the real pstate settings available
-        */
-       pstate_table->gfxclk_pstate.standard =3D gfx_table->min;
-       pstate_table->uclk_pstate.standard =3D mem_table->min;
+       if (driver_clocks.BaseClockAc &&
+               driver_clocks.BaseClockAc < gfx_table->max)
+               pstate_table->gfxclk_pstate.standard =3D driver_clocks.Base=
ClockAc;
+       else
+               pstate_table->gfxclk_pstate.standard =3D gfx_table->max;
+       pstate_table->uclk_pstate.standard =3D mem_table->max;
        pstate_table->socclk_pstate.standard =3D soc_table->min;
        pstate_table->vclk_pstate.standard =3D vclk_table->min;
        pstate_table->dclk_pstate.standard =3D dclk_table->min;
--
2.34.1

