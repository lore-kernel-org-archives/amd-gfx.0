Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32414C61DA4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 08:28:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C42F10E300;
	Mon,  6 Feb 2023 08:28:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::616])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A63910E128
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 08:28:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSNFcrNLWp6aROQMvdnLfDDE8iJwdNrgOnUZW8H0OD8jXx3ov8QJde5VqgB32KL4LgETxxt+enywFP9oQze9RUyszzEUuz44MtJdjSG+RQ+4iG0WcmHEXn5SxeKHaWRIdyXiBA7Y/aCKSBCUGCt7yEnhBEx+t8vfH/5kY6G8vjT08liwkmLM2kkp4mW91GTUVlk+uv9mwX3uPXJXto9LF7EUT4+pBFFNs4vut0c6WPvjLhE1tYCqmNYVKWjrNYc0WA7z2vQWyPJiubMsCWvyARlc8aZGsYMMu0b0AgJbF6cHWJ+hZDjEfm3spQyQvOFZ0IRoHKJwnTCta7Y27oFtpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2/AMXY73M1992OsrVJipFFL5oYktXql2rJMXU36rOI=;
 b=HCl8oTDMZByUD+thGZKe2EH5g2hS2fB9CeeQYCAK+BO9VoyIhPOGVyQckOJNlnqiAUg/ir0wkqZPSGq7Wz16MmYvT8QuIttr3BEWRoe2Eh1haKUMRerGa+tZz9PRIxbDsE0Q5TUXk7QwrrpMxgZYU6DZaGOkhaBQfMuUOhHyBQs+t+lQ0Dr6eGXCVfBUTPDT3m5yzJyVterCtgA7biOjVifBsHUy5btwQQU4omygl/WMlhnxHP5I8j0VB39NLcBELrL8LIWFN6/7cB67Rwd0/mnox62F8EVZLQlHBpp/puHFnTKCPNDDljG7oAMK61ANgCzTMLqT0pqSUkR8m+KbhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2/AMXY73M1992OsrVJipFFL5oYktXql2rJMXU36rOI=;
 b=DLj+0Hd+5zocS+ZoqP4WQOp48b9QPDAh+e15J1LJF+jrGZ10TlE0P9kAZ51R8zxmac39RQFwOQZx3OvdMgoB/W+/RYjvKDureXfDQZgrpco+ZrfdyzjXhwtmSEF2MXcsfkynv0BBpa8+7WibxelfquHq76o8VV3mjFNgNh7V0QM=
Received: from MW3PR12MB4458.namprd12.prod.outlook.com (2603:10b6:303:5d::10)
 by BY5PR12MB4886.namprd12.prod.outlook.com (2603:10b6:a03:1c5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 08:28:05 +0000
Received: from MW3PR12MB4458.namprd12.prod.outlook.com
 ([fe80::bac5:385f:b991:c9c0]) by MW3PR12MB4458.namprd12.prod.outlook.com
 ([fe80::bac5:385f:b991:c9c0%4]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 08:28:05 +0000
From: "Xiao, Jack" <Jack.Xiao@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA is
 unavailable
Thread-Topic: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA is
 unavailable
Thread-Index: AQHZNuxfg8FNVol4pke6J9qzLuANM667iUeAgAExmRCAAHu1gIAES/RQgAATLwCAAAHxgA==
Date: Mon, 6 Feb 2023 08:28:05 +0000
Message-ID: <MW3PR12MB4458C18F7080280760953EACEFDA9@MW3PR12MB4458.namprd12.prod.outlook.com>
References: <20230202095416.4039818-1-Jack.Xiao@amd.com>
 <BYAPR12MB35899E39061894E55AC07FE383D69@BYAPR12MB3589.namprd12.prod.outlook.com>
 <MW3PR12MB4458B37F3A4E9AF91F35279FEFD79@MW3PR12MB4458.namprd12.prod.outlook.com>
 <a4d8d310-c2e0-f2e5-74e8-fe8a5c34501e@gmail.com>
 <MW3PR12MB4458263C5E9B1071F7831EF7EFDA9@MW3PR12MB4458.namprd12.prod.outlook.com>
 <9ac594eb-9b59-02e1-fc7f-a745e28ff201@amd.com>
In-Reply-To: <9ac594eb-9b59-02e1-fc7f-a745e28ff201@amd.com>
Accept-Language: en-001, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-06T08:28:02Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=adad6312-bef2-444d-a06a-1e5fadbddc33;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-02-06T08:28:02Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 8c593388-f974-47b5-bfd6-018a66771821
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4458:EE_|BY5PR12MB4886:EE_
x-ms-office365-filtering-correlation-id: 5139bc97-1577-4f17-8e54-08db081c11f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3TmRxYu0N8ER6AJXTmTOPUZm1pY0iRgiB0cq4N/ERd5AMPyfoTfNJXtST+yaGQpdCxn7eU30b5MsZBm4G+H9FK4m0vUf0l7I6gbXPy1MGkYcP+qxLLqMqO+1LpRjk/uCJb6m/oPLgdGFvRhAOjHEySPphnsf/eIAERe5F9knpho0TGk4mY/uH11hsnPBXZuhP2j5rhCQMcVAHaoWREZnGy8fIuRGfRVIrZsxlyiXdqz1cGwHmt0ovwjq7A945/xnkLBQfAMEv8F6tY1Zq47LKVmsZkZaLU7WwVm/pTpAXMf6qJx+rPobiKPv1lWbMEZeoo1DHLwcgGdNFbAyPpLOw3Jbb2hLdE6MUHBKrtBDTNNr03BqkfI3e5RAosKQuz3C+GKX7NAgO8IUztQuxvVGqunC0ugleuHlsz+Zeg49sJPh+wf3Na5EWLVl90sOttVyB3KEYYHljj7vjBOhUL1HXHIc62GmG/grui3NgO3VcPZKifaEyxr7V2564oFkwBk5hsZbwgl778ENp91i1lW4wymVHDo5JlXp/2cKB4XEmphzXbcYcfqHP4/BPQEuBTt0qVMy6nSywQKi/c5MrlwRFEwewiU1GyqLBpm6j0P5rtYNOwlUlTdA/9ZW43FWkNZ+o6zw1jvCVopE/LvC6DurrVoNY5TvXATbFROBdfnkL+HVcJvQ1JzH+xNd7Qk2kihGH1A4A1U2c28fjNsjzph8WQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4458.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199018)(71200400001)(7696005)(478600001)(316002)(6636002)(110136005)(53546011)(6506007)(5660300002)(52536014)(186003)(9686003)(26005)(33656002)(86362001)(38100700002)(122000001)(66574015)(55016003)(38070700005)(83380400001)(76116006)(66946007)(2906002)(8676002)(8936002)(41300700001)(66446008)(66556008)(64756008)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rIkLYLeinrUTkL5Vouv151QLtp28q4906V/wp4uL81m8sJY9snXxo9z7UN?=
 =?iso-8859-1?Q?yTj9KvFlOoR89FMh8X4sA8XOQPCDexkLTT+xd+QQkWa6Uk0m+y6D9jlXtB?=
 =?iso-8859-1?Q?zMcI3Du3808IzgZBJGoLMJPg1DemBesTRd/T69rmQwYHW41CNpbcua+2o/?=
 =?iso-8859-1?Q?JViX4GgiMxsPwKrvp6AD/Nyg03Lz1znezFyKgRwUduRQ/WB0AjbHdUSPTw?=
 =?iso-8859-1?Q?6sUu/Ivs+EW5sJHOCwS+EslMxTSv/Yks/lzR0PBG+LYQD1PcKaE4p+AcCy?=
 =?iso-8859-1?Q?Q++EUkHSZwFvDRGMdMXJt0yvK1JEbXQI3PMixQKmq2bH4ekXorG1506/Us?=
 =?iso-8859-1?Q?wkiSc+LWM90EdVQqxQt3VZvJQ9mi0edGNEqnGa8vQhBE05qOOncxN9BPcw?=
 =?iso-8859-1?Q?rWMt/ToYSCFkveTyF5QzDUbgMWuaFTRj/KpopDuEe4m/VOpmbcaXZ7E2Q2?=
 =?iso-8859-1?Q?lWKiK3mAsVGSyxD8Yz29ShyP8AlQpy9eLsQQPN+q0QIpFkCIFCky6KR2UJ?=
 =?iso-8859-1?Q?2qkR4XEnUA+gIs2JV+qNoG9InHkfwom2bZPQNn+Avgc3+u1zhsZsuaJAyM?=
 =?iso-8859-1?Q?JsmcURol8kzt1P5NZXsYmhFGDusRYfMHdC0SzLDf3dqzNjZsTgk4G7LEuZ?=
 =?iso-8859-1?Q?47izQ157Vq9x3UHGmLs0rpdHm1LQTK9gXJSc/0nSGy429Alw2C2ceX4fyx?=
 =?iso-8859-1?Q?eozD97d40doGmKe+kO+wySlOBfFoLk/l5ERCLa3dWUhWb31GuY7LPL/209?=
 =?iso-8859-1?Q?mMcFwoFIOGt+UZGxkmffna8KpUAdILNoHrRmxpcQcnUY7P9JAWheRBhic+?=
 =?iso-8859-1?Q?94O0Onyz1EbLjR92Y4eToEiFSGrfhEiaNat5OK469a7+A0Ks00zn7QjDes?=
 =?iso-8859-1?Q?KlnsMwkgiE9TvSNll9jx7I+0xk+cgjkl9rM6anUrHPjWZ6c4K/IKYJ/WzT?=
 =?iso-8859-1?Q?8J9fGem1ruXRakgDCPUw+5YTlRtA1vMY4QkkskF0E2/tYtlliGDV5DjY5Q?=
 =?iso-8859-1?Q?Q23yztBT2IZcL/fvPMST67bx0wgCxYGwmnio2slarXyHXvb0bsan94DnQb?=
 =?iso-8859-1?Q?ErIDBq3ceaVlP2WjrhS5p5BV6kEoKolhGw1Dw+22PDxO+doTN8NR/uQmYa?=
 =?iso-8859-1?Q?f9Pp8nQwvvkmtarTKfE59IKhNJ2kAj13vGA8KZrql5oqw8QGzDzT4jmLCn?=
 =?iso-8859-1?Q?0U6mXkrERVlQ6b3/MqUDJyiFve2BLfpCQxqQcA6/iwC2ruFBpuMAofRgyo?=
 =?iso-8859-1?Q?8+GfXuaeDofWITXarCc18yrhKnSyV6E6pRVD88QfqGloYtzDZh9uZtii+U?=
 =?iso-8859-1?Q?x6rnOTZ3DeMoqemO/foEi0+8Br/hkruCyKwold5G2trDAG5jQOIspZmbz2?=
 =?iso-8859-1?Q?6AdJSgQqrFExN2/gJL26BDeY+LaQL/wFNIRrZme538SsHYnpK6tRZvE9T8?=
 =?iso-8859-1?Q?9SfBFYMSO+fFtdZyKzWH1Dozcd9v8Fdr/1slJnLelyLyC5vqWCCqmX8nE0?=
 =?iso-8859-1?Q?6gJdPqpMlCTuDT0z8shCH63qc1T2ZMgCPZ9rdE7Cd2KtXfF5J11a/dqP/c?=
 =?iso-8859-1?Q?g6uSvv+ny7nVFlOzIaxG6E1S4bBjIgdRCIQ9Y3jP+0F/QvcXBwSz6tTRIz?=
 =?iso-8859-1?Q?YSMeWO5dXlpqQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_MW3PR12MB4458C18F7080280760953EACEFDA9MW3PR12MB4458namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4458.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5139bc97-1577-4f17-8e54-08db081c11f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 08:28:05.5959 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Bn8xSzZ192+NVn8QT6ORO9VjRCp2lN6SVSPPM7ei9jSSaM7eW2IyXZWot3boQAX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4886
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

--_000_MW3PR12MB4458C18F7080280760953EACEFDA9MW3PR12MB4458namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

                              >> >> It's simply not allowed to free up reso=
urces during suspend since those can't be acquired again during resume.
                              >> The in_suspend flag is set at the beginnin=
g of suspend and unset at the end of resume. It can't filter the case you m=
entioned.

               Why not? This is exactly what it should do.

[Jack] If freeing up resources during resume, it should not hit the issue y=
ou described. But only checking in_suspend flag would take these cases as w=
arning.

Regards,
Jack

From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Monday, February 6, 2023 4:06 PM
To: Xiao, Jack <Jack.Xiao@amd.com>; Christian K=F6nig <ckoenig.leichtzumerk=
en@gmail.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander=
.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA is unav=
ailable

Am 06.02.23 um 08:23 schrieb Xiao, Jack:

[AMD Official Use Only - General]

>> Nope, that is not related to any hw state.

can use other flag.

>> It's simply not allowed to free up resources during suspend since those =
can't be acquired again during resume.
The in_suspend flag is set at the beginning of suspend and unset at the end=
 of resume. It can't filter the case you mentioned.

Why not? This is exactly what it should do.

Do you know the root cause of these cases hitting the issue? So that we can=
 get an exact point to warn the freeing up behavior.

Well the root cause are programming errors. See between suspending and resu=
ming you should not allocate nor free memory.

Otherwise we can run into trouble. And this check here is one part of that,=
 we should probably add another warning during allocation of memory. But th=
is here is certainly correct.

Regards,
Christian.


Thanks,
Jack

From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com><mailto:ckoenig.l=
eichtzumerken@gmail.com>
Sent: Friday, February 3, 2023 9:20 PM
To: Xiao, Jack <Jack.Xiao@amd.com><mailto:Jack.Xiao@amd.com>; Koenig, Chris=
tian <Christian.Koenig@amd.com><mailto:Christian.Koenig@amd.com>; amd-gfx@l=
ists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; Deucher, Alexan=
der <Alexander.Deucher@amd.com><mailto:Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA is unav=
ailable

Nope, that is not related to any hw state.

It's simply not allowed to free up resources during suspend since those can=
't be acquired again during resume.

We had a couple of cases now where this was wrong. If you get a warning fro=
m that please fix the code which tried to free something during suspend ins=
tead.

Regards,
Christian.
Am 03.02.23 um 07:04 schrieb Xiao, Jack:

[AMD Official Use Only - General]

>> It's simply illegal to free up memory during suspend.
Why? In my understanding, the limit was caused by DMA shutdown.

Regards,
Jack

From: Koenig, Christian <Christian.Koenig@amd.com><mailto:Christian.Koenig@=
amd.com>
Sent: Thursday, February 2, 2023 7:43 PM
To: Xiao, Jack <Jack.Xiao@amd.com><mailto:Jack.Xiao@amd.com>; amd-gfx@lists=
.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; Deucher, Alexander =
<Alexander.Deucher@amd.com><mailto:Alexander.Deucher@amd.com>
Subject: AW: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA is unav=
ailable

Big NAK to this! This warning is not related in any way to the hw state.

It's simply illegal to free up memory during suspend.

Regards,
Christian.

________________________________
Von: Xiao, Jack <Jack.Xiao@amd.com<mailto:Jack.Xiao@amd.com>>
Gesendet: Donnerstag, 2. Februar 2023 10:54
An: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>; Deucher=
, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.com>>; =
Koenig, Christian <Christian.Koenig@amd.com<mailto:Christian.Koenig@amd.com=
>>
Cc: Xiao, Jack <Jack.Xiao@amd.com<mailto:Jack.Xiao@amd.com>>
Betreff: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA is unavaila=
ble

Reduce waringings, only warn when DMA is unavailable.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com<mailto:Jack.Xiao@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c
index 2d237f3d3a2e..e3e3764ea697 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -422,7 +422,8 @@ void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *=
gpu_addr,
         if (*bo =3D=3D NULL)
                 return;

-       WARN_ON(amdgpu_ttm_adev((*bo)->tbo.bdev)->in_suspend);
+       WARN_ON(amdgpu_ttm_adev((*bo)->tbo.bdev)->in_suspend &&
+               !amdgpu_ttm_adev((*bo)->tbo.bdev)->ip_blocks[AMD_IP_BLOCK_T=
YPE_SDMA].status.hw);

         if (likely(amdgpu_bo_reserve(*bo, true) =3D=3D 0)) {
                 if (cpu_addr)
--
2.37.3



--_000_MW3PR12MB4458C18F7080280760953EACEFDA9MW3PR12MB4458namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.msipheaderdf3d92d6, li.msipheaderdf3d92d6, div.msipheaderdf3d92d6
	{mso-style-name:msipheaderdf3d92d6;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"purple" style=3D"word-wrap:b=
reak-word">
<div class=3D"WordSection1">
<p class=3D"msipheaderdf3d92d6" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only - General]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &=
gt;&gt; &gt;&gt; It's simply not allowed to free up resources during suspen=
d since those can't be acquired again during resume.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; The in_suspend flag is =
set at the beginning of suspend and unset at the end of resume. It can&#821=
7;t filter the case you mentioned.<o:p></o:p></p>
<p class=3D"MsoNormal"><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; Why not? This is exactly what it should do.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">[Jack] If freeing up resources during resume, it sho=
uld not hit the issue you described. But only checking in_suspend flag woul=
d take these cases as warning.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Jack<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Koenig, Christian &lt;Christian.Koenig@=
amd.com&gt; <br>
<b>Sent:</b> Monday, February 6, 2023 4:06 PM<br>
<b>To:</b> Xiao, Jack &lt;Jack.Xiao@amd.com&gt;; Christian K=F6nig &lt;ckoe=
nig.leichtzumerken@gmail.com&gt;; amd-gfx@lists.freedesktop.org; Deucher, A=
lexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA =
is unavailable<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Am 06.02.23 um 08:23 =
schrieb Xiao, Jack:<o:p></o:p></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"msipheaderdf3d92d6" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only - General]</span><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; Nope, that is not related to any hw state.<=
o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">can use other flag.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">&gt;&gt; It's simply =
not allowed to free up resources during suspend since those can't be acquir=
ed again during resume.<o:p></o:p></p>
<p class=3D"MsoNormal">The in_suspend flag is set at the beginning of suspe=
nd and unset at the end of resume. It can&#8217;t filter the case you menti=
oned.<o:p></o:p></p>
</blockquote>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><br>
Why not? This is exactly what it should do.<br>
<br>
<o:p></o:p></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoNormal">Do you know the root cause of these cases hitting th=
e issue? So that we can get an exact point to warn the freeing up behavior.=
<o:p></o:p></p>
</blockquote>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><br>
Well the root cause are programming errors. See between suspending and resu=
ming you should not allocate nor free memory.<br>
<br>
Otherwise we can run into trouble. And this check here is one part of that,=
 we should probably add another warning during allocation of memory. But th=
is here is certainly correct.<br>
<br>
Regards,<br>
Christian.<br>
<br>
<o:p></o:p></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Jack<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Christian K=F6nig <a href=3D"mailto:cko=
enig.leichtzumerken@gmail.com">
&lt;ckoenig.leichtzumerken@gmail.com&gt;</a> <br>
<b>Sent:</b> Friday, February 3, 2023 9:20 PM<br>
<b>To:</b> Xiao, Jack <a href=3D"mailto:Jack.Xiao@amd.com">&lt;Jack.Xiao@am=
d.com&gt;</a>; Koenig, Christian
<a href=3D"mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt=
;</a>; <a href=3D"mailto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a>; Deucher, Alexander <a href=3D"mailto:Ale=
xander.Deucher@amd.com">
&lt;Alexander.Deucher@amd.com&gt;</a><br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA =
is unavailable<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Nope, that is not rel=
ated to any hw state.<br>
<br>
It's simply not allowed to free up resources during suspend since those can=
't be acquired again during resume.<br>
<br>
We had a couple of cases now where this was wrong. If you get a warning fro=
m that please fix the code which tried to free something during suspend ins=
tead.<br>
<br>
Regards,<br>
Christian.<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">Am 03.02.23 um 07:04 schrieb Xiao, Jack:<o:p></o:p><=
/p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"msipheaderdf3d92d6" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only - General]</span><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; It's simply illegal to free up memory durin=
g suspend.<o:p></o:p></p>
<p class=3D"MsoNormal">Why? In my understanding, the limit was caused by DM=
A shutdown.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Jack<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Koenig, Christian <a href=3D"mailto:Chr=
istian.Koenig@amd.com">
&lt;Christian.Koenig@amd.com&gt;</a> <br>
<b>Sent:</b> Thursday, February 2, 2023 7:43 PM<br>
<b>To:</b> Xiao, Jack <a href=3D"mailto:Jack.Xiao@amd.com">&lt;Jack.Xiao@am=
d.com&gt;</a>;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a>; Deucher, Alexander
<a href=3D"mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&=
gt;</a><br>
<b>Subject:</b> AW: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA =
is unavailable<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">Big NAK to this! This warning is not related in any =
way to the hw state.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">It's simply illegal to free up memory during suspend=
.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Christian.<o:p></o:p></p>
</div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">Von:</span></b><span =
style=3D"color:black"> Xiao, Jack &lt;<a href=3D"mailto:Jack.Xiao@amd.com">=
Jack.Xiao@amd.com</a>&gt;<br>
<b>Gesendet:</b> Donnerstag, 2. Februar 2023 10:54<br>
<b>An:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;; Deucher, Alexander &lt;<a href=3D"mailt=
o:Alexander.Deucher@amd.com">Alexander.Deucher@amd.com</a>&gt;;
 Koenig, Christian &lt;<a href=3D"mailto:Christian.Koenig@amd.com">Christia=
n.Koenig@amd.com</a>&gt;<br>
<b>Cc:</b> Xiao, Jack &lt;<a href=3D"mailto:Jack.Xiao@amd.com">Jack.Xiao@am=
d.com</a>&gt;<br>
<b>Betreff:</b> [PATCH] drm/amdgpu: only WARN freeing buffers when DMA is u=
navailable</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Reduce waringings, on=
ly warn when DMA is unavailable.<br>
<br>
Signed-off-by: Jack Xiao &lt;<a href=3D"mailto:Jack.Xiao@amd.com">Jack.Xiao=
@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-<br>
&nbsp;1 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c<br>
index 2d237f3d3a2e..e3e3764ea697 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
@@ -422,7 +422,8 @@ void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *=
gpu_addr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*bo =3D=3D NULL)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(amdgpu_ttm_adev((*bo)-&gt;tbo=
.bdev)-&gt;in_suspend);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(amdgpu_ttm_adev((*bo)-&gt;tbo=
.bdev)-&gt;in_suspend &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; !amdgpu_ttm_adev((*bo)-&gt;tbo.bdev)-&gt;ip_blocks[AMD_IP_BLOCK_=
TYPE_SDMA].status.hw);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (likely(amdgpu_bo_reser=
ve(*bo, true) =3D=3D 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (cpu_addr)<br>
-- <br>
2.37.3<o:p></o:p></p>
</div>
</div>
</blockquote>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</blockquote>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_MW3PR12MB4458C18F7080280760953EACEFDA9MW3PR12MB4458namp_--
