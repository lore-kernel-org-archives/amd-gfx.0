Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41DE3C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 16:07:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A39AE10E6E5;
	Mon, 28 Mar 2022 16:07:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D6D910E6E5
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 16:07:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqVFcK0pd0ZWJAnwGQb3y/mj1h/4QVwQuFW+ozxEtlT/joMNnw7jehknoPNT77ZAFVcospEy66CWCas8b631AofOnGHXdMz+/1D8C2vUE08jA6anlmk9H7N63HZNZu5cL/Ytp/bvbvE2tCMbrbeRWnRMmhjkqLn+Jao23F8hteXPZwXNS3lE6Wg/Z0URpmfzPHr4DnaAXUobSm38Ixx2YINOaqz2SrqyFgjxBYFfyzE6kmpX/7HNKmWBY4o7ubItHRvQ3tgRWtAmxNUm42ZdkQhjCqcX5RM1TjjuRd0VwjD3/a2LFMHaRGfwq7f7PQ+Y4gX/KPmUXEhCoQR2wpVQVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pCWnEPd0QNVW21RrugdlkF1yTh15Mx2ZAK0BRfrpAw=;
 b=JMl3meVUMacly/Lj/x4l297BQ71J5jjlyatBXQSdwvPZPx/P+8yj8zTzYQBOWufV6jiHy4qLhy2qZygqH04iGH9kiOCUIPY1jENjNxpc2kX2fKJ8JfL+ueoUFx9dTZwGIyzSxycTAZv4XIPdU47bRigbCYA4Jzy2P4Hk7q+5VxkQHdpRrBh68WAkySiRZ01pi+FbTTkDDG9/FHH1FMTu6I04Jfaw3lntBxeYx4yVU9WsfWcW2k+fSn8xVIPfNv6bxDuyzcZHfplvG0K0mhUgteD4Cny+zyHA/TRtwsD4Skac9lTrMIJ4sM3MeryZix+pl5dOJq404uOIQN1DiD7qKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pCWnEPd0QNVW21RrugdlkF1yTh15Mx2ZAK0BRfrpAw=;
 b=YNmfKvanGgTLRwGa0SksbwvDovMVRQonqX4lvVmsqLoPmX5+m53J4qHmBeZO6kzUaOXsLny42rPiPQ35IcD6al9Pcp9y0aXLXX8A50g1LnpMO08GmYqAxRCPsejk4FVo30l8M8vsKDQ5H7UaPOmhydxEx8pMUwc6aOkxs6rxEc8=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BN6PR12MB1585.namprd12.prod.outlook.com (2603:10b6:405:9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Mon, 28 Mar
 2022 16:07:52 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d851:76d6:b1e6:4a06]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d851:76d6:b1e6:4a06%5]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 16:07:52 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: Add unique_id support for sienna cichlid
Thread-Topic: [PATCH 2/2] drm/amdgpu: Add unique_id support for sienna cichlid
Thread-Index: AQHYQrEdtstt3QfxmE6RA10SvhgF7qzU6IsAgAAHDoCAAAGOgIAAAW4AgAACvMM=
Date: Mon, 28 Mar 2022 16:07:52 +0000
Message-ID: <BYAPR12MB46143E0A5A0F64D2BCBA68B5971D9@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <20220328143518.1253762-1-kent.russell@amd.com>
 <20220328143518.1253762-2-kent.russell@amd.com>
 <80529a89-effc-368a-da12-14d7e44c860d@amd.com>
 <DM5PR12MB1308FBF96617FF1DDE124158851D9@DM5PR12MB1308.namprd12.prod.outlook.com>
 <c319f4e0-c01a-d355-9878-7f09a5f33b49@amd.com>
 <DM5PR12MB1308F91A509695ECB9CA6C8B851D9@DM5PR12MB1308.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1308F91A509695ECB9CA6C8B851D9@DM5PR12MB1308.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-28T15:49:54.0000000Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP
 2.0; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17ce1b40-bfe1-4552-26b3-08da10d51ce5
x-ms-traffictypediagnostic: BN6PR12MB1585:EE_
x-microsoft-antispam-prvs: <BN6PR12MB1585EF2A1D19B1EA97E787C7971D9@BN6PR12MB1585.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VBXUdNbs2Q94prR3kRWHKfys0J/wvsNgBgBeCN3SY4z//nBmO5BlDhGd0bIvfNbekHqMle90eL7ecyyhHsdv/mpqPEcxQ8tDCnNiYPsKYkniG6MckO3KDUyVpCIgr/dBojwW6zEBmP4bwgWXAtj9migNFFVmkKM9b6RXEtezajFj3mKvLBiORGR2qMJujlaCfdQSbFtpY9FMm56jumrf12TDasIKCwbELybtGgln9uvEUNNqOWZ9H0Yzo4/UZUex69Q7AZtEOCZPPFXxEDDo5lt2EHN7IEY7YLLWCrPRR5f6p5R64TaQ+ecC8oUjBJqzrmmlvshpQU2aj9XKaidyTsrwPnIOI0rLNbNOVWCOoCFiSXKR90bKQDbHbufTBMjVolBLtv5emmxpENTvRPR6FO0NjIKUuKvrCavQIVN9F8baaW8uaxUwIKj0Z4m96cEwzqneNlcf6sysp0ZljhKnaOCSxz55Grg/k+gXyfHDYGr7X7HxDAuEEEGvj+mzGRFP08Blj1bdtOiMyG0VyDyZDKYWCcaVPVO2qPPIZuMcYOnLBA/GBdHQLWuTYaoy4YLKSkaA6ttcz85KXbCrj7Pvz/deY3su78ZCImtydoZiBVQxr8FhB8nShwSLiMNyJyJVpm6ENhIdnMgGVPFBZj2dJc9w8GGD/rby5xYFVjGmu7M+XCIi+p9qtHObxp5WWwXy8kMiBSAJ2rWU4zUoH6iE+w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(38070700005)(33656002)(316002)(122000001)(110136005)(55016003)(508600001)(7696005)(6506007)(86362001)(53546011)(52536014)(8936002)(5660300002)(66946007)(76116006)(9686003)(91956017)(66556008)(26005)(186003)(4326008)(8676002)(66446008)(83380400001)(71200400001)(2906002)(64756008)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YHTt7BeisZxfONs+Eh12x8qmyMgGfQtBXetYAO8csmfrZ7G3cgZt/6Joeqss?=
 =?us-ascii?Q?OEJW4XkN8Lg2tTUmKURFrVgwytcWs66LNnF4S9g+uWKJIgmDUm9nbL4Aouwi?=
 =?us-ascii?Q?r8pNQY9KTkUGaS3ayd8mOhHQTZFpffAO+ggWAh2DmOA29oQzFyzifgRxJmIU?=
 =?us-ascii?Q?LLEtmbMff6bHc08zdizzq/bZQrt7UL8PB/UpVlLZ34Vbvjt36N2NW7bVncU8?=
 =?us-ascii?Q?sAb1XKZe2AgOIqAEDhHalGeDD3vM5+Yx+FzvxPp9qwvwlVh0ig2nSg3LRR5A?=
 =?us-ascii?Q?FjZAnwNLZIh+/ITnIFtQaOIVEPCxDsiqENBSydJ/yLqy09SJTgpYPy+1Fojq?=
 =?us-ascii?Q?lKk93tNvQqAo9xUIQJt777bb2ZKTO0OgUoFJdX7943g54bB3Y/lRQuwgyrNf?=
 =?us-ascii?Q?ir6cwrJaUozxdoPRk7Vt7kYIaadv24jVpTHRENNO9IFGMBzjsayAz5Yo96MP?=
 =?us-ascii?Q?wD+GhSNhJGli9PSK+H720nrYspQuavCJ0Jm8PNXjCLfsN7xnt2/I/oX0M/8P?=
 =?us-ascii?Q?aYYkbRKJUun6a0VFzE0OxMTBQGY+nsNOV4HYIFH4ElaXCWEZwjKcGpJ8n1v1?=
 =?us-ascii?Q?SuKw9gpY+vP7ulFxtAQi79Kh+6UCDhhWILnewhKFkrio6ko3pmrUsT1FYbtt?=
 =?us-ascii?Q?peXFlCJN/y2UFJ6MYp4sw3M8sdWTP59K3J8rPTbfbaCFZ2h3VyDPKG2yvsDI?=
 =?us-ascii?Q?OMWbtmcw5FU4bXi1IkWpRBzRESxIPSwOX9VJUfqye5UF+tna8AA4CyPrJnEp?=
 =?us-ascii?Q?19b0BxxF8qh6z7jbymO/uzWRCJMmQbBz2+sGIuCNkwp+0/xWEXrHEewYOfWd?=
 =?us-ascii?Q?eHYu3+Hm4TK4VQ51n4ki6+oUxIKkJTz6PUslJEG55LzTRdMtJnAKB/VQKlnc?=
 =?us-ascii?Q?8HrON0uDZ+HeypbY2cYOYd1rDu+R+nR24gIrASU8gPzntpX9xs1be1VOUd8R?=
 =?us-ascii?Q?b/uyz9+cq+WEH9OowSCMtKFLN0ljHOKPg36gAvj8AVTAfg4eJI9ssYvupUAk?=
 =?us-ascii?Q?4kY1Lp06UqLzKVFbH7s6A79ldoq9va9dAn0uWBh2svDSlIb4qvqod8IIZQa8?=
 =?us-ascii?Q?VZ/U2UPLsS9PmcGdoMFzwZh+DPwpYaJyZSgNO3LKFD0nI8nEEUPcHLeMT822?=
 =?us-ascii?Q?KA0gh1ye9LlYJaPeu4gIOBADyUBXO+QxrIhVIBKomu9oQgRbthyyQGNu9oyH?=
 =?us-ascii?Q?mGaIDqzAVWdzMkuEs7/tWH/LTqHFGbZmY9QUZDUGWo5J+J/aL6u0ARd1FJY0?=
 =?us-ascii?Q?0CZ7I5MP/IzeZ8H/FfvintiWFE02fJ1nblqr73fGCqr6gqIwaEdnM2EVYKHs?=
 =?us-ascii?Q?mK0Me1Ox8pbLfa1k5iX3bx3XZ/JEB8Iwg4o64Qy53bhwy01kgnsobaLlQ3r9?=
 =?us-ascii?Q?w5LfGs9wuqDkBhHkPMelLQIT09xTvl4LdSgQsiwgiFqHmqNn1M9ffm0OjJX2?=
 =?us-ascii?Q?Nvgc9ltfd7BDVaYjUF3YVpwdbbijbEc73DWKW6e0gRkZpqXny4jXKTuP3PuY?=
 =?us-ascii?Q?R0h328obTY+xiRCHWB36gajOXV/miSvnHkXyg8upCDoWxIGtDtCB3T4lGRzM?=
 =?us-ascii?Q?X731elkH0nlrFa0/cKbiG9kiKBlzo1oRA2wcLTxdxMKmEL2zk8rT8Za1BAwM?=
 =?us-ascii?Q?TX0Rd1oHOBlOQElSCb+MJgWAuTgJRfcCGJuqdZGjusdJvPXHxf8Ca1sc6nVC?=
 =?us-ascii?Q?yWS1d9OjnQ1rs9HZJZcY0RK9y9jAU1Y71DyWC7/a0zQvmf7FASwJXKoHWMWN?=
 =?us-ascii?Q?CyBNTJnjuA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR12MB46143E0A5A0F64D2BCBA68B5971D9BYAPR12MB4614namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ce1b40-bfe1-4552-26b3-08da10d51ce5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 16:07:52.3329 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1xt4HAmXn7In0JueD1gHrzquRT0g/EJOUSCoq8Yjw2QiT+PWoVSmaaSRn9WhPmsS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1585
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BYAPR12MB46143E0A5A0F64D2BCBA68B5971D9BYAPR12MB4614namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Yes, that check looks good.

A couple of other things -

PMFW ticket as a comment is not needed.
I remember Satish updating the same struct for smartshift related data. Som=
e additional fields added towards the end. Not sure if Sienna struct also c=
arries those fields. Regardless, you may check if that affects the placemen=
t of serial number fields (whether before or after those fields).


Thanks,
Lijo
________________________________
From: Russell, Kent <Kent.Russell@amd.com>
Sent: Monday, March 28, 2022 9:23:36 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Add unique_id support for sienna cichl=
id

[AMD Official Use Only]

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Monday, March 28, 2022 11:48 AM
> To: Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH 2/2] drm/amdgpu: Add unique_id support for sienna cic=
hlid
>
>
>
> On 3/28/2022 9:12 PM, Russell, Kent wrote:
> > [AMD Official Use Only]
> >
> > Responses inline
> >
> >> -----Original Message-----
> >> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> >> Sent: Monday, March 28, 2022 11:18 AM
> >> To: Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.or=
g
> >> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> >> Subject: Re: [PATCH 2/2] drm/amdgpu: Add unique_id support for sienna =
cichlid
> >>
> >>
> >>
> >> On 3/28/2022 8:05 PM, Kent Russell wrote:
> >>> This is being added to SMU Metrics, so add the required tie-ins in th=
e
> >>> kernel. Also create the corresponding unique_id sysfs file.
> >>>
> >>> v2: Add FW version check, remove SMU mutex
> >>> v3: Fix style warning
> >>>
> >>> Signed-off-by: Kent Russell <kent.russell@amd.com>
> >>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> >>> ---
> >>>    drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  1 +
> >>>    .../pmfw_if/smu11_driver_if_sienna_cichlid.h  | 12 +++++--
> >>>    .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 36 +++++++++++++++=
++++
> >>>    3 files changed, 47 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> >> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> >>> index 4151db2678fb..4a9aabc16fbc 100644
> >>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> >>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> >>> @@ -1993,6 +1993,7 @@ static int default_attr_update(struct amdgpu_de=
vice *adev,
> >> struct amdgpu_device_
> >>>              case IP_VERSION(9, 4, 0):
> >>>              case IP_VERSION(9, 4, 1):
> >>>              case IP_VERSION(9, 4, 2):
> >>> +           case IP_VERSION(10, 3, 0):
> >>>                      *states =3D ATTR_STATE_SUPPORTED;
> >>>                      break;
> >>>              default:
> >>> diff --git
> >> a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cich=
lid.h
> >> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cich=
lid.h
> >>> index 3e4a314ef925..58f977320d06 100644
> >>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna=
_cichlid.h
> >>> +++
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid=
.h
> >>> @@ -1419,8 +1419,12 @@ typedef struct {
> >>>      uint8_t  PcieRate               ;
> >>>      uint8_t  PcieWidth              ;
> >>>      uint16_t AverageGfxclkFrequencyTarget;
> >>> -  uint16_t Padding16_2;
> >>>
> >>> +  //PMFW-8711
> >>> +  uint32_t PublicSerialNumLower32;
> >>> +  uint32_t PublicSerialNumUpper32;
> >>> +
> >>> +  uint16_t Padding16_2;
> >>>    } SmuMetrics_t;
> >>>
> >>>    typedef struct {
> >>> @@ -1476,8 +1480,12 @@ typedef struct {
> >>>      uint8_t  PcieRate               ;
> >>>      uint8_t  PcieWidth              ;
> >>>      uint16_t AverageGfxclkFrequencyTarget;
> >>> -  uint16_t Padding16_2;
> >>>
> >>> +  //PMFW-8711
> >>> +  uint32_t PublicSerialNumLower32;
> >>> +  uint32_t PublicSerialNumUpper32;
> >>> +
> >>
> >> Is this the case for other ASICs also which share the metrics data wit=
h
> >> Sienna?
> >
> > No, only for Sienna Cichlid. The PMFW guys didn't implement it for Navy=
 Flounder or
> Dimgrey Cavefish.
> >
> >>
> >>> +  uint16_t Padding16_2;
> >>>    } SmuMetrics_V2_t;
> >>>
> >>>    typedef struct {
> >>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> >> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> >>> index 38f04836c82f..550458f6246a 100644
> >>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> >>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> >>> @@ -481,6 +481,41 @@ static int sienna_cichlid_setup_pptable(struct s=
mu_context
> >> *smu)
> >>>      return sienna_cichlid_patch_pptable_quirk(smu);
> >>>    }
> >>>
> >>> +static void sienna_cichlid_get_unique_id(struct smu_context *smu)
> >>> +{
> >>> +   struct amdgpu_device *adev =3D smu->adev;
> >>> +   struct smu_table_context *smu_table =3D &smu->smu_table;
> >>> +   SmuMetrics_t *metrics =3D
> >>> +           &(((SmuMetricsExternal_t *)(smu_table->metrics_table))->S=
muMetrics);
> >>> +   SmuMetrics_V2_t *metrics_v2 =3D
> >>> +           &(((SmuMetricsExternal_t *)(smu_table->metrics_table))->S=
muMetrics_V2);
> >>> +   uint32_t upper32 =3D 0, lower32 =3D 0;
> >>> +   bool use_metrics_v2;
> >>> +   int ret;
> >>> +
> >>> +   /* Only supported as of version 0.58.83.0 */
> >>> +   if (smu->smc_fw_version < 0x3A5300)
> >>> +           return;
> >>> +
> >>
> >> Since this is shared with other ASICs, I guess this check itself may n=
ot
> >> be enough. This function may be skipped if it's not MP1 11.0.7 or GC 1=
0.3.0?
> >>
> >
> > Since the sysfs file is only supported on Sienna Cichlid (10.3.0), is i=
t a concern since the tie-
> in won't exist on the other SMU11-based ASICs? And this function is only =
referenced by
> sienna_cichlid, unless I misunderstood something (and someone else uses
> sienna_cichlid_tables_init).
> >
>
> This function also gets called as part of common init sequence -
> smu_get_unique_id.
> If PMFW version of Navi Flounder/Dimgrey ASIC is greater than Sienna,
> then it may go to the path which is not intended to be executed on that
> ASIC.

Would it be sufficient to just confirm the IP_VERSION here too then?
 e.g.
/* Only supported as of version 0.58.83.0 and only on Sienna Cichlid (GC 10=
.3.0)*/
if (smu->smc_fw_version < 0x3A5300 || adev->ip_versions[GC_HWIP][0] !=3D IP=
_VERSION(10, 3, 0))
          return;

Thus the FW has to be that version, and the IP_VERSION has to be 10.3 ? Or =
is there a better method to use? Thanks!

 Kent

>
> Thanks,
> Lijo
>
> >   Kent
> >
> >> Thanks,
> >> Lijo
> >>
> >>> +   ret =3D smu_cmn_get_metrics_table(smu, NULL, false);
> >>> +   if (ret)
> >>> +           goto out_unlock;
> >>> +
> >>> +   use_metrics_v2 =3D ((smu->adev->ip_versions[MP1_HWIP][0] =3D=3D I=
P_VERSION(11, 0,
> >> 7)) &&
> >>> +           (smu->smc_fw_version >=3D 0x3A4300)) ? true : false;
> >>> +
> >>> +   upper32 =3D use_metrics_v2 ? metrics_v2->PublicSerialNumUpper32 :
> >>> +                              metrics->PublicSerialNumUpper32;
> >>> +   lower32 =3D use_metrics_v2 ? metrics_v2->PublicSerialNumLower32 :
> >>> +                              metrics->PublicSerialNumLower32;
> >>> +
> >>> +out_unlock:
> >>> +
> >>> +   adev->unique_id =3D ((uint64_t)upper32 << 32) | lower32;
> >>> +   if (adev->serial[0] =3D=3D '\0')
> >>> +           sprintf(adev->serial, "%016llx", adev->unique_id);
> >>> +}
> >>> +
> >>>    static int sienna_cichlid_tables_init(struct smu_context *smu)
> >>>    {
> >>>      struct smu_table_context *smu_table =3D &smu->smu_table;
> >>> @@ -4182,6 +4217,7 @@ static const struct pptable_funcs sienna_cichli=
d_ppt_funcs =3D {
> >>>      .get_ecc_info =3D sienna_cichlid_get_ecc_info,
> >>>      .get_default_config_table_settings =3D
> >> sienna_cichlid_get_default_config_table_settings,
> >>>      .set_config_table =3D sienna_cichlid_set_config_table,
> >>> +   .get_unique_id =3D sienna_cichlid_get_unique_id,
> >>>    };
> >>>
> >>>    void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
> >>>

--_000_BYAPR12MB46143E0A5A0F64D2BCBA68B5971D9BYAPR12MB4614namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
Yes, that check looks good.</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
A couple of other things -&nbsp;</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
PMFW ticket as a comment is not needed.</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
I remember Satish updating the same struct for smartshift related data. Som=
e additional fields added towards the end. Not sure if Sienna struct also c=
arries those fields. Regardless, you may check if that affects the placemen=
t of serial number fields (whether
 before or after those fields).</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<br>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">Thanks,<br>
Lijo</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Russell, Kent &lt;Ken=
t.Russell@amd.com&gt;<br>
<b>Sent:</b> Monday, March 28, 2022 9:23:36 PM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amdgpu: Add unique_id support for sienn=
a cichlid</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">[AMD Official Use Onl=
y]<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
&gt; Sent: Monday, March 28, 2022 11:48 AM<br>
&gt; To: Russell, Kent &lt;Kent.Russell@amd.com&gt;; amd-gfx@lists.freedesk=
top.org<br>
&gt; Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
&gt; Subject: Re: [PATCH 2/2] drm/amdgpu: Add unique_id support for sienna =
cichlid<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On 3/28/2022 9:12 PM, Russell, Kent wrote:<br>
&gt; &gt; [AMD Official Use Only]<br>
&gt; &gt;<br>
&gt; &gt; Responses inline<br>
&gt; &gt;<br>
&gt; &gt;&gt; -----Original Message-----<br>
&gt; &gt;&gt; From: Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
&gt; &gt;&gt; Sent: Monday, March 28, 2022 11:18 AM<br>
&gt; &gt;&gt; To: Russell, Kent &lt;Kent.Russell@amd.com&gt;; amd-gfx@lists=
.freedesktop.org<br>
&gt; &gt;&gt; Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
&gt; &gt;&gt; Subject: Re: [PATCH 2/2] drm/amdgpu: Add unique_id support fo=
r sienna cichlid<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On 3/28/2022 8:05 PM, Kent Russell wrote:<br>
&gt; &gt;&gt;&gt; This is being added to SMU Metrics, so add the required t=
ie-ins in the<br>
&gt; &gt;&gt;&gt; kernel. Also create the corresponding unique_id sysfs fil=
e.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; v2: Add FW version check, remove SMU mutex<br>
&gt; &gt;&gt;&gt; v3: Fix style warning<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Signed-off-by: Kent Russell &lt;kent.russell@amd.com&gt;<=
br>
&gt; &gt;&gt;&gt; Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&g=
t;<br>
&gt; &gt;&gt;&gt; ---<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/pm/amdgpu_pm.c&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 +<b=
r>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp; .../pmfw_if/smu11_driver_if_sienna_cich=
lid.h&nbsp; | 12 +++++--<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp; .../amd/pm/swsmu/smu11/sienna_cichlid_p=
pt.c&nbsp;&nbsp; | 36 +++++++++++++++++++<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp; 3 files changed, 47 insertions(+), 2 de=
letions(-)<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; &gt;&gt; b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; &gt;&gt;&gt; index 4151db2678fb..4a9aabc16fbc 100644<br>
&gt; &gt;&gt;&gt; --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; &gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; &gt;&gt;&gt; @@ -1993,6 +1993,7 @@ static int default_attr_update(stru=
ct amdgpu_device *adev,<br>
&gt; &gt;&gt; struct amdgpu_device_<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 0):<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 1):<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 2):<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; case IP_VERSION(10, 3, 0):<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *state=
s =3D ATTR_STATE_SUPPORTED;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;=
<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; default:<br>
&gt; &gt;&gt;&gt; diff --git<br>
&gt; &gt;&gt; a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_si=
enna_cichlid.h<br>
&gt; &gt;&gt; b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_si=
enna_cichlid.h<br>
&gt; &gt;&gt;&gt; index 3e4a314ef925..58f977320d06 100644<br>
&gt; &gt;&gt;&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driv=
er_if_sienna_cichlid.h<br>
&gt; &gt;&gt;&gt; +++<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cich=
lid.h<br>
&gt; &gt;&gt;&gt; @@ -1419,8 +1419,12 @@ typedef struct {<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t&nbsp; PcieRate&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; ;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t&nbsp; PcieWidth&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t AverageGfxclkFrequ=
encyTarget;<br>
&gt; &gt;&gt;&gt; -&nbsp; uint16_t Padding16_2;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +&nbsp; //PMFW-8711<br>
&gt; &gt;&gt;&gt; +&nbsp; uint32_t PublicSerialNumLower32;<br>
&gt; &gt;&gt;&gt; +&nbsp; uint32_t PublicSerialNumUpper32;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +&nbsp; uint16_t Padding16_2;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp; } SmuMetrics_t;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp; typedef struct {<br>
&gt; &gt;&gt;&gt; @@ -1476,8 +1480,12 @@ typedef struct {<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t&nbsp; PcieRate&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; ;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t&nbsp; PcieWidth&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t AverageGfxclkFrequ=
encyTarget;<br>
&gt; &gt;&gt;&gt; -&nbsp; uint16_t Padding16_2;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +&nbsp; //PMFW-8711<br>
&gt; &gt;&gt;&gt; +&nbsp; uint32_t PublicSerialNumLower32;<br>
&gt; &gt;&gt;&gt; +&nbsp; uint32_t PublicSerialNumUpper32;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Is this the case for other ASICs also which share the metrics=
 data with<br>
&gt; &gt;&gt; Sienna?<br>
&gt; &gt;<br>
&gt; &gt; No, only for Sienna Cichlid. The PMFW guys didn't implement it fo=
r Navy Flounder or<br>
&gt; Dimgrey Cavefish.<br>
&gt; &gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt; +&nbsp; uint16_t Padding16_2;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp; } SmuMetrics_V2_t;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp; typedef struct {<br>
&gt; &gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_ci=
chlid_ppt.c<br>
&gt; &gt;&gt; b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
&gt; &gt;&gt;&gt; index 38f04836c82f..550458f6246a 100644<br>
&gt; &gt;&gt;&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_p=
pt.c<br>
&gt; &gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_p=
pt.c<br>
&gt; &gt;&gt;&gt; @@ -481,6 +481,41 @@ static int sienna_cichlid_setup_ppta=
ble(struct smu_context<br>
&gt; &gt;&gt; *smu)<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sienna_cichlid_patch=
_pptable_quirk(smu);<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +static void sienna_cichlid_get_unique_id(struct smu_cont=
ext *smu)<br>
&gt; &gt;&gt;&gt; +{<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&gt;adev=
;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; struct smu_table_context *smu_table =3D &am=
p;smu-&gt;smu_table;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; SmuMetrics_t *metrics =3D<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;(((SmuMetricsExternal_t *)(smu_table-&gt;metrics_table))-&gt;SmuM=
etrics);<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; SmuMetrics_V2_t *metrics_v2 =3D<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;(((SmuMetricsExternal_t *)(smu_table-&gt;metrics_table))-&gt;SmuM=
etrics_V2);<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; uint32_t upper32 =3D 0, lower32 =3D 0;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; bool use_metrics_v2;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; int ret;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; /* Only supported as of version 0.58.83.0 *=
/<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; if (smu-&gt;smc_fw_version &lt; 0x3A5300)<b=
r>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; return;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Since this is shared with other ASICs, I guess this check its=
elf may not<br>
&gt; &gt;&gt; be enough. This function may be skipped if it's not MP1 11.0.=
7 or GC 10.3.0?<br>
&gt; &gt;&gt;<br>
&gt; &gt;<br>
&gt; &gt; Since the sysfs file is only supported on Sienna Cichlid (10.3.0)=
, is it a concern since the tie-<br>
&gt; in won't exist on the other SMU11-based ASICs? And this function is on=
ly referenced by<br>
&gt; sienna_cichlid, unless I misunderstood something (and someone else use=
s<br>
&gt; sienna_cichlid_tables_init).<br>
&gt; &gt;<br>
&gt;<br>
&gt; This function also gets called as part of common init sequence -<br>
&gt; smu_get_unique_id.<br>
&gt; If PMFW version of Navi Flounder/Dimgrey ASIC is greater than Sienna,<=
br>
&gt; then it may go to the path which is not intended to be executed on tha=
t<br>
&gt; ASIC.<br>
<br>
Would it be sufficient to just confirm the IP_VERSION here too then?<br>
&nbsp;e.g.<br>
/* Only supported as of version 0.58.83.0 and only on Sienna Cichlid (GC 10=
.3.0)*/<br>
if (smu-&gt;smc_fw_version &lt; 0x3A5300 || adev-&gt;ip_versions[GC_HWIP][0=
] !=3D IP_VERSION(10, 3, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
<br>
Thus the FW has to be that version, and the IP_VERSION has to be 10.3 ? Or =
is there a better method to use? Thanks!<br>
<br>
&nbsp;Kent<br>
<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Lijo<br>
&gt;<br>
&gt; &gt;&nbsp;&nbsp; Kent<br>
&gt; &gt;<br>
&gt; &gt;&gt; Thanks,<br>
&gt; &gt;&gt; Lijo<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; ret =3D smu_cmn_get_metrics_table(smu, NULL=
, false);<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; if (ret)<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; goto out_unlock;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; use_metrics_v2 =3D ((smu-&gt;adev-&gt;ip_ve=
rsions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0,<br>
&gt; &gt;&gt; 7)) &amp;&amp;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (smu-&gt;smc_fw_version &gt;=3D 0x3A4300)) ? true : false;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; upper32 =3D use_metrics_v2 ? metrics_v2-&gt=
;PublicSerialNumUpper32 :<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; metrics-&gt;PublicSerialNumUppe=
r32;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; lower32 =3D use_metrics_v2 ? metrics_v2-&gt=
;PublicSerialNumLower32 :<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; metrics-&gt;PublicSerialNumLowe=
r32;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +out_unlock:<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; adev-&gt;unique_id =3D ((uint64_t)upper32 &=
lt;&lt; 32) | lower32;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; if (adev-&gt;serial[0] =3D=3D '\0')<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; sprintf(adev-&gt;serial, &quot;%016llx&quot;, adev-&gt;unique_id);<br>
&gt; &gt;&gt;&gt; +}<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp; static int sienna_cichlid_tables_init(s=
truct smu_context *smu)<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp; {<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *s=
mu_table =3D &amp;smu-&gt;smu_table;<br>
&gt; &gt;&gt;&gt; @@ -4182,6 +4217,7 @@ static const struct pptable_funcs s=
ienna_cichlid_ppt_funcs =3D {<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_ecc_info =3D sienna_ci=
chlid_get_ecc_info,<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_default_config_table_s=
ettings =3D<br>
&gt; &gt;&gt; sienna_cichlid_get_default_config_table_settings,<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_config_table =3D sienn=
a_cichlid_set_config_table,<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; .get_unique_id =3D sienna_cichlid_get_uniqu=
e_id,<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp; };<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp; void sienna_cichlid_set_ppt_funcs(struc=
t smu_context *smu)<br>
&gt; &gt;&gt;&gt;<br>
</span></font></div>
</span></font></div>
</div>
</body>
</html>

--_000_BYAPR12MB46143E0A5A0F64D2BCBA68B5971D9BYAPR12MB4614namp_--
