Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DCFC76196
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Apr 2023 07:28:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65A7F10E4C8;
	Tue, 11 Apr 2023 07:28:17 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::60f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE40710E430
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 07:28:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dsy63Ed4X6G5uwaKeIGHxmjaOpE5tDq1jRSQYJKklPr8qdnWmcVscNiiAr4gDMEFNg2cwLFAOLbbz2Mlz040u4qw6uYhS0IWnMMg15Jd7wnOVdtCdi9io2tDWuzyoyj+9LRW4Wiwb9PROaXFkZbs9ELpJCuFJ/nlZbuirE2OMr9nVt/ueJrxh1pDqGRyPv6K82mAs382UNXV7KKCngqOyhFNmlvg196OJYel1zAqk3xTNRjckrACVwlK7oa+r0Y2N+sUBu87TVX3PhJ2fa1ZLgg/reJNvspRgaGJaCj2oBd/at5vD8xl11n5e+t6GEOMfC18EE7Uj/CfyrtiT78fyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WnXxB4T/y+qmb8uB6HQBHnpoJYLEAwl3N5E/dhZI6hk=;
 b=jeaGupC+lDNKrdVVBEznS4NVFkTgIKmEiW+3dxI2IVyu8mxz7kmSQJBQthlCKgS6LbefyZb06h1Ajb65oImvWIj1miykgWgBSzba+N7eKIpemmp5GCwA99aT/6K/iPHCqe50RzSWr0MMjtQPGUjziN3uGX0K79B1kxNW8AmnVIJA/3Q9y2fNCqKtPrXOC6zZUnv4whd+PGVqr4xzCzgd7/pJOlKorTHKg/A1t2EwtnYHup7INIppC4cQ3JbBVMf57HKnhcyTGP9Tcnk8C/DpVw+eojX0UmHUzLlPnjBHP0Ptk3aJbjPW1rdI6ml1z/kvWJEBOI0oUt7Vj0lWYgslOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnXxB4T/y+qmb8uB6HQBHnpoJYLEAwl3N5E/dhZI6hk=;
 b=JagVi4k9myBHKcpJkRDiG/dn3VeohQAKyZAWId3Sy2hRXFOPk3hhqi4x+U2DUUWvB721jTS6jvIH2k9JEh59J0DqgK1l5tb2MgvlzzVE2tQBsZQUkV/hQODPiEbG7CcNanSf3LEim+9gLUtI8cnsZ0yIzYjbPKoxGyt0xcI9KS4=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by BL3PR12MB6617.namprd12.prod.outlook.com (2603:10b6:208:38c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 07:28:10 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::3f0f:783a:2620:4b1c]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::3f0f:783a:2620:4b1c%6]) with mapi id 15.20.6277.036; Tue, 11 Apr 2023
 07:28:10 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH Review 1/2] drm/admgpu: fix unexpected block id
Thread-Topic: [PATCH Review 1/2] drm/admgpu: fix unexpected block id
Thread-Index: AQHZa6JdWrAmzfBiYEK7wtu4+1H8ga8limeAgAAsdEA=
Date: Tue, 11 Apr 2023 07:28:10 +0000
Message-ID: <BL1PR12MB5334D3A4F6FF982466495A299A9A9@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20230410114822.750-1-Stanley.Yang@amd.com>
 <DM5PR12MB2469412275D1DA66DD4BC186F19A9@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2469412275D1DA66DD4BC186F19A9@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-11T07:28:06Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6163e710-6f5c-461f-9ae7-074c8539f5df;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-11T07:28:06Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 7990c49d-d243-4fc3-a19e-5d40a4441689
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5334:EE_|BL3PR12MB6617:EE_
x-ms-office365-filtering-correlation-id: 62456990-520d-4ad7-18b4-08db3a5e4d6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /aifpTCGd7ZYAomzbn0ZXfC+YXAn2ChWstz5lXG/+ZTye6X7rVsn5ttWpU0T7rIoX2q7FsDTJrj1AhrtowZdVSg8gAMC/u2jrztzFx45e6WiZHSZsfXTt2tuZtpMEN2hR0b1WBarThA5qMqkywKClIZ8Zcm2rlhrtvGfGRvSo55ygNYVV2Qz0tC3oxTF2sXOHCPteNqLu5vgagbTppZQ7J8Dd0D2XYiR5imqIi9IEiDyGsvJASkPzQmuCncAlxBf63i6l0HN+bAJEbv8oF/vlBBccIX1ExIXfmRUAQkDESRqZW0TKIiN92NL47dKCDPR7Cm8ISYxkHpwvczIKJnTz24bKcOj8FLS1KVQPZGhmL3GbxdqWsCm+pvBWwpkZrXVXCLdPAc/qNmiK8OLew45vGhwIPD5uYkizKigmNIi2e3yz10IEbQS/yOtZHXIvsKcbUcMQMfpIE0P4+0zxXlQxi84gdgNJIns6U6rXDyIHUGq1hB/FDiU3hVDB3CdrGgrHRNj2+BayBjOeDkdrsYA/bVbe33UwVra03GRsxIslhZ4F0aEc6ETef1r0+wp0KOkSFwALAN0p07yIFBql/CvOocavck2y//DMTnjKZe1Bm/knfEdRU+LKBXd2M8IEIuV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199021)(33656002)(86362001)(71200400001)(7696005)(41300700001)(110136005)(316002)(66946007)(76116006)(478600001)(66446008)(66476007)(64756008)(66556008)(6636002)(55016003)(5660300002)(52536014)(8676002)(8936002)(2906002)(53546011)(38100700002)(186003)(38070700005)(122000001)(6506007)(26005)(9686003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B6ZFw5IeRM7MYAyNpVzcp1tk+egwbBRzu+cxLSYIMHxJTvG8RzjJRYn85nWr?=
 =?us-ascii?Q?6cDtDNDfbum1ZExakSALLdRhyl+J4ElUvAtbAL0Xngp3qfu30eWCYRNdjfUJ?=
 =?us-ascii?Q?XDOGHjPzazl3XGCluTGb1ow/BMuX9pzSw2IA19kMba78sQZBj1UB/Wl5sodD?=
 =?us-ascii?Q?LdiR+TeYv1eE6SsE517NDYTab0w4M1HWWsiqX0kATOUVPcpkiqvNN/78Q7OZ?=
 =?us-ascii?Q?auWe6OurDvAlM/PmBCJFjz96bbgy/KmV82RGYG0nXtQSB6aSqJaCE3r0mNm6?=
 =?us-ascii?Q?gfuV++8RsTTh8GzU6378Ot2wIGbcg6X0N0LwfagiHkYzMYXZ/AK+8cvK+2lO?=
 =?us-ascii?Q?7GCv+ppfpD023cD+q/bqKWRvDjDsS00H4v+tVYm/hqdBC5c4nRqRSgXVSynW?=
 =?us-ascii?Q?cxDYSwg9bfxyKVgkejmquEw1eqSSC9QG/TqA8d7wNz0Beps26kd6h7CQ+Hyp?=
 =?us-ascii?Q?lQ1ImqP55DIr+JyOGnH417p10GRQ3b6aI3uwhWPQ3HeQUmKUGKqPuzREwu0R?=
 =?us-ascii?Q?CdbscOXNLtuBm/DNpe3qbyYaR1Oc84s2oOI6bLTfcdfo5zP9MnV+wMENhk+T?=
 =?us-ascii?Q?MCmq60sNI7kvums+KgM2qNL29XT02xCcMfVEE76H/tJ81paULW1eM5yAQSfr?=
 =?us-ascii?Q?LrmX/k9MncmXq2YHSiiXrnSBugs7YoC4WjqAlBWK14Tf6nHOrQTCQYf++DuO?=
 =?us-ascii?Q?zOw+9w9i6lLxGTP2RKMZd3o7ZHq0HYaXqto2KYKW+EBXDwJQjhFARDFQH/Vz?=
 =?us-ascii?Q?cIcnh//yQdY72uXXqr/z4rcBfpCn7JzJJeK108zx2xcUwNl7W7DUjeymIJKh?=
 =?us-ascii?Q?+fLXwrOXYgwCgJUERmDIGdRiJe8MoBjy4qRLf016xkzBjbuuD9oR9heRvBY+?=
 =?us-ascii?Q?K2I5rdgjHHyk9N2U8YQmUHfzavcCNQc37aRpVNZF1ik/Ye8RtxdPujxSIIMV?=
 =?us-ascii?Q?phYwPst6Nqmanu/7/CXbvIhrQzyYsCS4sCpNo5eBSdeMe8XDAObvxQgFGm0W?=
 =?us-ascii?Q?4hbTAqO7a2F6pgp8Nz7AAwTrtZOC8r+kiXjxVuEv0tzqQrUaxxl3VDVN7tba?=
 =?us-ascii?Q?p204UApt3JX3ZkOe9gWJVfWJ0o3ny1xXuyJgGXelE+K6CqwwP8NyjSvacZDz?=
 =?us-ascii?Q?XVsD/MD8gPmBv+L+IrfFyxropZJe8n0nbs7O68cCg4q9sltJo/SOYc8uJI1m?=
 =?us-ascii?Q?0elg3qYu4J8YiwBc/GgrUbi/kZNC9W3Nejqhtad+8Kfe5zdRGDuVfk2V1y99?=
 =?us-ascii?Q?LhZwb4fthYT50kUYf9YGdrJjaeqqLe+XXXJkJLt2FxLkMXZToMJgDPJUHAnl?=
 =?us-ascii?Q?YT5X0WvAJsTyDL1XAx3prWIONCNyIJGA6d1wFkc1U1RJGvAfIcWsabRqrrei?=
 =?us-ascii?Q?ETG1XzUCzDuL8FwI2R7VsdVtkgE3J6KP+RRJsE696mS53a4c1Oj+2obtPUD6?=
 =?us-ascii?Q?dKkb1SFq3zzjnCNuTZg8Gy9IB4itLJXBuCFVkgG6te/gsUOa3YwdRot21xWv?=
 =?us-ascii?Q?uA/hFppY7rp864azY0Dk+oleRr+Uv2TOFSM4sICOx9eEG1DFnW9I8G+V8jkQ?=
 =?us-ascii?Q?xCqgfTn9u42QXJdBRpg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62456990-520d-4ad7-18b4-08db3a5e4d6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 07:28:10.2824 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ddzIwf3qC5qiUO3htpj4wOs5IyYkQXGiihiUwKhxH/UpMHihgZBH9RYM+8G31YPBAXQm4Uaf2Cy4aZG2smM7fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6617
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

Hi Guchun,

Thanks, will update.

Regards,
Stanley

> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Tuesday, April 11, 2023 12:48 PM
> To: Yang, Stanley <Stanley.Yang@amd.com>; amd-gfx@lists.freedesktop.org;
> Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: RE: [PATCH Review 1/2] drm/admgpu: fix unexpected block id
>=20
> A spelling typo in subject, s/admgpu/amdgpu :)
>=20
> Also maybe it's necessary to add a body text in commit message.
>=20
> Regards,
> Guchun
>=20
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Stanley.Yang
> > Sent: Monday, April 10, 2023 7:48 PM
> > To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> > <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
> > Cc: Yang, Stanley <Stanley.Yang@amd.com>
> > Subject: [PATCH Review 1/2] drm/admgpu: fix unexpected block id
> >
> > Change-Id: Icceb43556eec802f11c2077c1c58a1e92c9df599
> > Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 4 ++++
> > drivers/gpu/drm/amd/amdgpu/ta_ras_if.h  | 2 ++
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> > index ef38f4c93df0..17b3d1992e80 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> > @@ -583,6 +583,10 @@ amdgpu_ras_block_to_ta(enum
> amdgpu_ras_block
> > block) {
> >  		return TA_RAS_BLOCK__FUSE;
> >  	case AMDGPU_RAS_BLOCK__MCA:
> >  		return TA_RAS_BLOCK__MCA;
> > +	case AMDGPU_RAS_BLOCK__VCN:
> > +		return TA_RAS_BLOCK__VCN;
> > +	case AMDGPU_RAS_BLOCK__JPEG:
> > +		return TA_RAS_BLOCK__JPEG;
> >  	default:
> >  		WARN_ONCE(1, "RAS ERROR: unexpected block id %d\n",
> block);
> >  		return TA_RAS_BLOCK__UMC;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
> > b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
> > index 509d8a1945eb..30d0482ac466 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
> > @@ -84,6 +84,8 @@ enum ta_ras_block {
> >  	TA_RAS_BLOCK__MP1,
> >  	TA_RAS_BLOCK__FUSE,
> >  	TA_RAS_BLOCK__MCA,
> > +	TA_RAS_BLOCK__VCN,
> > +	TA_RAS_BLOCK__JPEG,
> >  	TA_NUM_BLOCK_MAX
> >  };
> >
> > --
> > 2.17.1
