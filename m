Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1B4C6FA82
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 14:12:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B804710EB34;
	Thu, 22 Sep 2022 14:12:47 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EE8F10EB32
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 14:12:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwfYe7XLALn0mCnz71jBUpqmJIXKB0dqqkLOmz9CO/TTQETr9ovJdyOAZ6vV+gVg1DtJQHQ5lrlgcKBvW/f2kX90ebvVRQE2ELDR5owQXX401Waf1gXune35xiQi0pbynR2efzZB+qbIVcKAPVjsNGqxtfXRTVQuJlEJFJWsjGBEHnGvy80msScVYAsomvG09tc/NfcaRyT49MRpwT0rQHFBw67RCTW1BGdzX+cW5Jh1DIkAR/BsYb3goCJ3Pbxf+nGgVvkDL4VHqfuRMyjf4DkkarTsBzYVIYGqVbOyPd0GxTKo1DtHQct5/E78Euesc3Dn3jtYr/PukNpwCobkvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ru/7QOxSfW/iZLxqsMBDDyz8MysmYDe0n1bWd+Kt0mQ=;
 b=XqWP+k07eScDgkRZKsSveMt8SiqFXQ8mzhxmR/wlPBPLhHf6TLScgamQZ4e9NENMGMr8p5+F+wpINChdJmZPKVvytwoEj1ANvyo1g3LrxVbb0geAEJ4HMvZu0A5sAbfuuxftQ0PCwMr6CZN20stDst+r4H0SbzNa6aMukMkaK3JkqEI3hSirxEbEK2yD4+w6v0MXbWaTNmd+PylHGUC+c0WJCz2JGOlTDADpwbPsYA/jh3Y/1VD3ZBJ9IJquBpYhI37OBES8GhpEirJOqWgphEXgkyuscmqm2fI1LzDp13kckNzFeXbiYL2rStRYccDjIHLm3Bll2lJToMVei1QzTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ru/7QOxSfW/iZLxqsMBDDyz8MysmYDe0n1bWd+Kt0mQ=;
 b=l2WObkVJvV9b3gi2R177xqNFRP/0QT3DQy9MWg2u8WTOOO3GbQKvNA5wGoCpRKPcBG9RwkgYUhnvpbWCxDSZnQGe6aVfZvqbMrY88PpRy75es4tO6C+DGamW7sa2TyaviejCVKfsLBeGWrBngLyGonwoEMN+lfP6WR0PqO929Bg=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by CY8PR12MB7145.namprd12.prod.outlook.com (2603:10b6:930:5f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Thu, 22 Sep
 2022 14:12:41 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::cd37:1141:7fec:389d]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::cd37:1141:7fec:389d%4]) with mapi id 15.20.5654.018; Thu, 22 Sep 2022
 14:12:40 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: "Dhillon, Jasdeep" <Jasdeep.Dhillon@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 21/31] Add ABM control to panel_config struct.
Thread-Topic: [PATCH 21/31] Add ABM control to panel_config struct.
Thread-Index: AQHYzhj4sMsrBaxF5k2+Y/f6C4S5va3rfmqi
Date: Thu, 22 Sep 2022 14:12:40 +0000
Message-ID: <CH0PR12MB528472A00F1E6250E02E57238B4E9@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20220922001821.320255-1-jdhillon@amd.com>
 <20220922001821.320255-22-jdhillon@amd.com>
In-Reply-To: <20220922001821.320255-22-jdhillon@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-22T14:12:40.062Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5284:EE_|CY8PR12MB7145:EE_
x-ms-office365-filtering-correlation-id: 8f3ef106-6023-4e30-837a-08da9ca482b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eJSrnO1pCGhSyfrXXQEQlfKoqUB/sDVK03mFjLyn1CbIn2pAk+EAFqFf7yNlVvbeJCYVY+3nZXX2OtcrFFE5GzMz7t4VM/+nZLLVXvF6LmDXghvwsUQ0MmyIMmqfok3QgzbHz97aaRvcrQJMFH+3uxg0bVlK1obDmZNtop/QXgHKiyTrCvnZJ/N9ZQVq3SCBYqPCd9qFRbQYB6/SHfshpIbhl6xYfhNNzgAJA5qOIuZ9kzx6c/LGMPR6KYhEqaqcUmyGWCVZfpDFYY6FHU2NXdqPgJa8ODp1aciomejMMyASMWeTW7L1LEnEeewE0ECXLnLLZi5R16cDeRPI+UnpmeR92C1vfx5lL3j0Q7oTl6uE6HN/nskQc4TUdlGC6NpvRJ/+xrnBgNgt1dbe2f1cJ3NxLLNGgR8iRRUW0LAegzCNDP1Kdrd0MiJReSszPdQFHDbKC3SUvFjfDPmCVKNUQReWSuMlbYeHzckxL7bv9wf3Zaz5tmdgin/ByXZSCw8QLFreJgQYRbV2bRQ871M2L0PI0v+i1gE1/maXxqod8LxWvBT8q/BeYuDqMWm5bVUAulHpSl1D6dDiQKeuNkuQLUvmMMhnabbpXCy9VakhuA4sKCUv+km+Ihd44fuKPegkUwnAyk2yw7Q5CELRv8omoSdYiDoodHh6oJWo6JsgSovwg+WlLBA7Ej6mkdlD2niERlWr03+6+DZFS/8VOEpZvPAEzYqQpX1Eb6MwPRqrNDN4KbN9WWuJLoj5CIQ6suitnoSPkO3IgotxhmsrRBtcjg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199015)(52536014)(41300700001)(86362001)(71200400001)(8936002)(478600001)(5660300002)(54906003)(110136005)(66446008)(8676002)(66556008)(33656002)(76116006)(66946007)(316002)(66476007)(4326008)(64756008)(186003)(38100700002)(55016003)(38070700005)(122000001)(7696005)(6506007)(53546011)(9686003)(26005)(19627405001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ETDN5bTB30l1+9RJp7nLhCfIQDC0B/y1T7ygP/91dkRmSMKn+HioxdGjefn5?=
 =?us-ascii?Q?QEWrCGNATQvQiLmLiAlAAUD8PvkOeHdiczZ23+yP+etv7sJlSONIr9uSombE?=
 =?us-ascii?Q?N22D0gEqjh4eMYgtNoGwNog6fGXW3oyAtKrSMSZ2PWxaPy8r4F+UAot16gHj?=
 =?us-ascii?Q?dbxx9hkyplBMfz5gQ9cJqUuIHIF2BclVS/NJECDEZYteTus7y5JI2a+Kh7in?=
 =?us-ascii?Q?vV4MiW6HxO3TmIYQvVuCZ05LpzQj1t8L9BbM/AitVU8+QGL/eji5bzuFjiQX?=
 =?us-ascii?Q?hWtPJRDGKFkqAHMeM+z8T/NfmfcB/SgpgXsIaqj/dOLSe8vgcejc+dHN6iG5?=
 =?us-ascii?Q?MmWQcsn+VVasPAGKRSfHd/EVTCBccjeAFmfPf49dUb3MmPwwttNnQQZd2ZBF?=
 =?us-ascii?Q?tW9DQFvGMPY96NH74wZ3A0bt4qDo0fbi3UH/glIGWcMeWvA7BqFPks3eD8dO?=
 =?us-ascii?Q?pq+dnyt4lQB6wDnMkGsSrveK3+xIaSZsc54Q0T63AOfnT0zKaJpkUl14VgnB?=
 =?us-ascii?Q?+WgOwpMPrjKQ68RKjK+9Wd0pRMksa5v3/5vt5Km25b87plT3+MlXBsu3NNc1?=
 =?us-ascii?Q?q2rJmfRmwq1Z7fi8goBEcntXYko72a42HV+FrAvPfjFmx97YTozEdrCZxzHU?=
 =?us-ascii?Q?VhI6pWWjhjQvOo0gg3Isfa1Kxt84mMg+lAqn5y8A5khf53tktxosHoCT/Odl?=
 =?us-ascii?Q?MT1O/Qls2xV85NYpuoDJAyEGExO4G5unMqITqTQf6Ny5kv7PC4rdZK3Dfm68?=
 =?us-ascii?Q?+odOeWW3GiSF4WcXnVSVRrFTSO1O5iBrhpm7JI/cRU3BmSc79qb0hz6PJDFA?=
 =?us-ascii?Q?myxsSLsIl7SV5M/kDKl2fU5pgE0qpHb8uVSrkFVj2IUp0w8AJutVAeLjynaz?=
 =?us-ascii?Q?QUX4xnGXHcrF8KZvTIKhEHxiK9tJbXiqOn8OipOFUbT1UdjGhEYqzqCzD3oB?=
 =?us-ascii?Q?UFmD+9caHq/Da1S4W6mMsPvk/94mp3lO/ga3N7LMfClTnwu9OVQ/ywWEkBzi?=
 =?us-ascii?Q?b7oVBQdoheJ6EnfKs5zprojshC9I+5Fm4wX3sWzMtfvovupwQ1dkGVEzDSek?=
 =?us-ascii?Q?bm+tU5gn9uGXrf/IY+IMHbW6aNNDR5yRcKBTclYBJ4LksFVP1FaCUTBUrbCd?=
 =?us-ascii?Q?IpjZ/4lWGCfGyn15pSYFVq0oYkLOxSaTbQuwUQ8LigUjyPHJ354LwtqREPab?=
 =?us-ascii?Q?6grluzMFKBLeWA0H4yTQ8syz+4krTymmakGOo/WpZ18uXKiPB/wZGMyq6gW1?=
 =?us-ascii?Q?ihin8EHkJa8qClnZQbyqQ1wdjdaJcCPvGzP3Z7DyeZnB+lRQW2jtXji0OX1P?=
 =?us-ascii?Q?v/IjOnlcPicEShJ1A5q5teMylRviQeyE+PwTiH0gVFWYrh2Ub/zc+b7bvZck?=
 =?us-ascii?Q?s4qRd7s+EbDnkNspt98VCiN5GT+yMoZuxHC+beG6u/JhVrG44InK3xuw2LgB?=
 =?us-ascii?Q?1nAr2CYyxVrRAf0pWtlse03GVUpkw2nqIyhWB7j//oEuSr1IFJrQ69HEULTZ?=
 =?us-ascii?Q?FEFRtxiEQDygS4RJ+hM5/aAGASDfL6L6ItUpUQU4LvZCn9W+2eQSjp8zXWGT?=
 =?us-ascii?Q?ElsSk4Awi45GopnAD4o=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB528472A00F1E6250E02E57238B4E9CH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3ef106-6023-4e30-837a-08da9ca482b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 14:12:40.7275 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kMjcHZAdyIX3X1zul12RzDGvqOEZOCyF6UDWFLV8ZFyjr2SmvOwz2Rre/cCYqOomN83GI2Z/6RxJVVD0Xi24yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7145
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Chen,
 Ian" <Ian.Chen@amd.com>, "Pavic, Josip" <Josip.Pavic@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Chiu, 
 Solomon" <Solomon.Chiu@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CH0PR12MB528472A00F1E6250E02E57238B4E9CH0PR12MB5284namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Hi Jas,

Please add drm/amd/display prefix to the patch title.

--

Regards,
Jay
________________________________
From: Dhillon, Jasdeep <Jasdeep.Dhillon@amd.com>
Sent: Wednesday, September 21, 2022 8:18 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Li, Roman <Roman.Li@amd=
.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang=
@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Kotarac, Pavle <Pavle.Kota=
rac@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Chen, Ian <Ia=
n.Chen@amd.com>; Pavic, Josip <Josip.Pavic@amd.com>; Dhillon, Jasdeep <Jasd=
eep.Dhillon@amd.com>
Subject: [PATCH 21/31] Add ABM control to panel_config struct.

From: Ian Chen <ian.chen@amd.com>

Reviewed-by: Josip Pavic <Josip.Pavic@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Ian Chen <ian.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_link.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd=
/display/dc/dc_link.h
index 6e49ec262487..bf5f9e2773bc 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -127,6 +127,12 @@ struct dc_panel_config {
                 unsigned int extra_t12_ms;
                 unsigned int extra_post_OUI_ms;
         } pps;
+       // ABM
+       struct varib {
+               unsigned int varibright_feature_enable;
+               unsigned int def_varibright_level;
+               unsigned int abm_config_setting;
+       } varib;
         // edp DSC
         struct dsc {
                 bool disable_dsc_edp;
--
2.25.1


--_000_CH0PR12MB528472A00F1E6250E02E57238B4E9CH0PR12MB5284namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
Hi Jas,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
Please add drm/amd/display prefix to the patch title.<br>
</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Jay<br>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Dhillon, Jasdeep &lt;=
Jasdeep.Dhillon@amd.com&gt;<br>
<b>Sent:</b> Wednesday, September 21, 2022 8:18 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Li, Sun peng (Le=
o) &lt;Sunpeng.Li@amd.com&gt;; Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd=
.com&gt;; Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Pillai, Aurab=
indo &lt;Aurabindo.Pillai@amd.com&gt;; Zhuo, Qingqing (Lillian)
 &lt;Qingqing.Zhuo@amd.com&gt;; Li, Roman &lt;Roman.Li@amd.com&gt;; Lin, Wa=
yne &lt;Wayne.Lin@amd.com&gt;; Wang, Chao-kai (Stylon) &lt;Stylon.Wang@amd.=
com&gt;; Chiu, Solomon &lt;Solomon.Chiu@amd.com&gt;; Kotarac, Pavle &lt;Pav=
le.Kotarac@amd.com&gt;; Gutierrez, Agustin &lt;Agustin.Gutierrez@amd.com&gt=
;;
 Chen, Ian &lt;Ian.Chen@amd.com&gt;; Pavic, Josip &lt;Josip.Pavic@amd.com&g=
t;; Dhillon, Jasdeep &lt;Jasdeep.Dhillon@amd.com&gt;<br>
<b>Subject:</b> [PATCH 21/31] Add ABM control to panel_config struct.</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Ian Chen &lt;ian.chen@amd.com&gt;<br>
<br>
Reviewed-by: Josip Pavic &lt;Josip.Pavic@amd.com&gt;<br>
Acked-by: Jasdeep Dhillon &lt;jdhillon@amd.com&gt;<br>
Signed-off-by: Ian Chen &lt;ian.chen@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dc_link.h | 6 ++++++<br>
&nbsp;1 file changed, 6 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd=
/display/dc/dc_link.h<br>
index 6e49ec262487..bf5f9e2773bc 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h<br>
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h<br>
@@ -127,6 +127,12 @@ struct dc_panel_config {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; unsigned int extra_t12_ms;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; unsigned int extra_post_OUI_ms;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } pps;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // ABM<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct varib {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; unsigned int varibright_feature_enable;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; unsigned int def_varibright_level;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; unsigned int abm_config_setting;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } varib;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // edp DSC<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dsc {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; bool disable_dsc_edp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB528472A00F1E6250E02E57238B4E9CH0PR12MB5284namp_--
