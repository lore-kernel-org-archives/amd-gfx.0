Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3095AC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Oct 2022 18:52:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A66810E667;
	Tue, 11 Oct 2022 18:52:44 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F5C510E667
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Oct 2022 18:52:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnjDKTsiqCYH0QtKJ3v6wGpblvxOe3G/5v8yRAefhhn7BpYCHxh+m/UQ85hbGy9s4bPTWUg5MVGg+T2OrKhNPe0SbcDj/OQX1987G6uqlTmiIU1GfSJyojfCfS2ybmYP+se5nIfMXybK0WOWtkGCHfnC6OPE/Yq3zdlFnkp1uyv9AZbILlWK4p0+ZVYoqY/H96epFwJYEgL8Ihd1D2nVaIO+Wf4AqmCIkYLeakW3dvwrthken1snrhzZWTE79KmTgzj24vQGSy5yffSFFqpPZTHzKDhI0HyoTPlFzTa32pm+vE+atQgOL9rJpgLCCV3bFZlj6TrxAvEhxTxq5BZ4AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkA4S+sCPAWYydDcBL8caH63JDdFiDXlT1nDNCLLF3g=;
 b=ASzRRk41HwXffyiQAxkKV9hXK5zZd3Lk2VdrKxvDOcSKWNLTId0RbVo2iN70eRU3MSICm3dbYd0PnNoQulim2vmunO5/HX/s/5EFSrh9T9/rkh9BAfQCULN7cGJDr8ELtrTk2ytXNACg8zwpiyhg5l0gN359gpC12LSBEkGvYPynIjVFU+DaBcELmtp9WaGIFja1hzEdOWeHXAsAjwhIK1g8jILhuVhwLaeLcPuEDYAG5KnK6VCDQMZZ5IMzYmoQaRaXeiY0tEcSCJnhdaSEu/HPi9W3fZihalqx4MXD0IYBmF7N9coJAPJTaur6/m2o3z4ClmH7cIifbcQCwgNf5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkA4S+sCPAWYydDcBL8caH63JDdFiDXlT1nDNCLLF3g=;
 b=amSRfu4c900ZfvbEEXb4DVnBTkuyvPj5jbFJMTrnhthmi/7EVtJoq5YRejcmPo10VDifuJWtsTcyEGxJ/7hnHbRUmzVsyqREewqodIEknRtKIwSefjXLKWfagWICgUOYx1dcGJjhKln39Z3k41Lc3OTdv8jdvgpWhzED5ZrDs80=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 IA0PR12MB7652.namprd12.prod.outlook.com (2603:10b6:208:434::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.25; Tue, 11 Oct 2022 18:52:39 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::17d5:b7b7:de4b:9c33]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::17d5:b7b7:de4b:9c33%8]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 18:52:39 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 0/3] Update DC commit sequence
Thread-Topic: [PATCH 0/3] Update DC commit sequence
Thread-Index: AQHY3Zzxqvs0KT3mlkmdRC9sfLV/sq4Jibig
Date: Tue, 11 Oct 2022 18:52:39 +0000
Message-ID: <DS0PR12MB6534A8BD2F7445BEDAFC50469C239@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20221011181140.94595-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20221011181140.94595-1-Rodrigo.Siqueira@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-10-11T18:51:37Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=b0a1aca6-c8aa-4f9e-84c4-88417f6fc6cb;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-10-11T18:52:37Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 48a62b66-bfda-4fb0-a222-61b541ab2a1b
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|IA0PR12MB7652:EE_
x-ms-office365-filtering-correlation-id: c6aa4b89-96ba-4d44-d284-08daabb9c554
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PtlMI2uQIAG6UJ3CrCz426te3VOUMJzzhv1zufG8UmFToYshJhJBmcHFynFLUuN7LH4ZapTYKGIl6jo0UGTA5BNOyVZajuxz+t7/9JHrmdeQJ9u2twnDgySS4VcH2Mfx959FaXkvkhfruxMMzRhj1RDZhKCOB05QA6ADbsKqZoCwxXGe+2xe0kismMN2kk8KyBzoKSZLKXK+MRRILhEmfa3FeBGXNgZ1fxuW6X67IN/uk2m5rUdRS1VZkYZ7q1SQsYKzvPjsnfuWohDss5C4FUDZnN0qorohD6h/OVAF7L9TbNTbZBGeSjrG/SsQF6atGXrIav4bMh3h3qlmnTrTo7aL0Dy4r723Q/sYbYey1Gz8ZsW9qSvauKAwD4g/zrXdVNA8QUE8jKHHv/OIKbJu0bgmnvdLcg6k407/PnUxbh8Kaa6gTiSIBQajhyRgL5jYC4I4I3lG8gAm5KrGfnXv6HqIdpu5sLRkktzoR/X79TP1XqBqiQmErmAEeTTO4lJV5+Lb0NgIgIGG2LoV7QEBJkV9p0YDi990bPWYEUESxsNJ9rVGgtPBXi+biuBakYVCGSixJAzvlDI40KD6wPCgxXt27KIYMjkZT8rxzu55SQSbGZcsSM9tmRVABND9leiys2xLZcUYwJ2nbvjy+RrClzukOfVyorZI8Xq3lah7ngCybIUhv+LlZvGlE5hXmj05h7Y3UjfoQI5VQWAcEwE4wsWPlgipZQgcFeoM8F+gzeW0sYMqN+Vu76EUT4nQru08kN+CzEs+DF9mr7IGBvxgvDVFFbIk4tz622JrzhZtv0/k7zQqUc+Ce50KE8wACcyU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199015)(71200400001)(15650500001)(122000001)(38100700002)(83380400001)(26005)(9686003)(38070700005)(53546011)(41300700001)(7696005)(33656002)(2906002)(66446008)(66946007)(4326008)(64756008)(8676002)(478600001)(6506007)(54906003)(110136005)(76116006)(66476007)(316002)(8936002)(52536014)(186003)(55016003)(86362001)(5660300002)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yvxZ+xKugpFLeWjkKThqfXIbejcieWCENefORaQ811frBsOs1JvX6o5rzM?=
 =?iso-8859-1?Q?ZYXNAn+W4j/7y/HRqd6afxjAn1Cjun8WVqXCcR3fNtz31PpbAnmUOxpowm?=
 =?iso-8859-1?Q?wGG6k9br4pJEIsVByLD0LIGQnYvADr1dUTQo5GvjyDf4JQmxdWCL9o6tS2?=
 =?iso-8859-1?Q?96yLm9kXBTozwQimiWMa5iDl470uHaXJKQlB6EyFWK1FGJAIAeIdw1LFAb?=
 =?iso-8859-1?Q?8MDRnq9kbI19D1oud0W3H/EYTprQyvIj4CqIQYXl/nti5RyvbcdTzE4xJJ?=
 =?iso-8859-1?Q?W025WkNXBjSQQPpZReV2fFZoAVW93iDy+5CFeeokeRxYTKi54KBVRaMSDc?=
 =?iso-8859-1?Q?t75wRC33+VafZXrFBikyDZZ3Kowz7B2oCDZgr7qEUAbyUVQ0HvW5h2qlox?=
 =?iso-8859-1?Q?7yGZ9jA6onWMe9wrO8BX/mS/lqoPXcJo/VGBBeWaE8aWDdazn7X976bcHB?=
 =?iso-8859-1?Q?JWbi6SBWVNmzPLXmfgnSBOJnvIUZfEV0T6gt5aGXr6k/fP0Fn9r1mXJETe?=
 =?iso-8859-1?Q?W09jzqwifpro/KNKh2L4UcUrvpqhbWRXuFbASEVYnsl8X8tFLqY4VFvyY6?=
 =?iso-8859-1?Q?Y493CRsQ3sySmZWBj6tph5ArqeemC2FbdrN43a4nXZCVJ2d1p6VfKtYid7?=
 =?iso-8859-1?Q?Ery7kXApEzmUYk1r4puAbfTMA3tpnNKuxCONtuLK47gUQ1eHW+12j21le0?=
 =?iso-8859-1?Q?Q060NIrRtLzyvzKP8tanm6/Ode6JlKBd83TMNX/Clc+7Ve8bHe0Grr3CXp?=
 =?iso-8859-1?Q?lO6pQ9USQUHj3fOSYNyq2E1V8FH97ouGvA8EXMpjbfz7DelKMSQtzJ6zX9?=
 =?iso-8859-1?Q?kX5lDLC8BX2F86O6tbGiUjpIAGEHj6PgkmTlnjOzcfKTQc9J5uMwJ4l+c2?=
 =?iso-8859-1?Q?ybY/QJJ2+Wa+7mj1Y4HExoueCHhbcnnRtVx9lv98rf4sV2FWB9TQiIkDLg?=
 =?iso-8859-1?Q?v/t7KintnHQzzEcSmIe62JUlDI0NLveRz6wiWUz/+5QC4tAPcaKWQ2/XSs?=
 =?iso-8859-1?Q?ndZTTeIyfAYNLdLX7YR7AFmEuuD4rwHdXqs4yshgetAnMDrectT2KuIzxJ?=
 =?iso-8859-1?Q?wXchi3mR3qbglgrj6HEjaaAFsUsZNtrzAaD1v/j1/5xtPxn+LzU5vYLqnQ?=
 =?iso-8859-1?Q?EyBXcz2b3xXG8vJsF1CWjoPV730dhy/qJMNkVfS0x7hauvsTAj6UfvAsE9?=
 =?iso-8859-1?Q?daKzsonEukMOrrZcZLEGF7igiNxb5WXi4JR1HsSTdCtZ7sRG43EHJe/r7B?=
 =?iso-8859-1?Q?Bc9FsHJcxvBSz3aa00B0VxsrUXTcSv8eI+NT8ZjLwK5gbYHWYMOxWcoHdx?=
 =?iso-8859-1?Q?jwmeyJ2HtUWWAXKhHBAroXVFfv4QMc0WW7N+b2kcLE0Gg/uIVS70aZyROx?=
 =?iso-8859-1?Q?XiQFVUE2jxxHCHRzZNXSgqEym3VR5MKC1WxY7fut/zpBFLaifPYmF51wne?=
 =?iso-8859-1?Q?/Pm8BR/Clc42h5nOuSBYJPuA1YvqwJ3YegJsP1bxN+GvoW3jiww8O0uJoP?=
 =?iso-8859-1?Q?ThPNS+xklwLTFb1+EBPkNcgKApOJZWosMl3yHxFeSsS1b5F+i4MhtCtZd3?=
 =?iso-8859-1?Q?DU8CDspBqh4IcZClzZ2x+6MtilUEk5q7BS2LvtVh+Oi8M0IT1wnve71bom?=
 =?iso-8859-1?Q?8mBXb3RUCRTqQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6aa4b89-96ba-4d44-d284-08daabb9c554
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 18:52:39.4004 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HZdYIo2IWvKbez1+CYlozCuIEFb13sfToUD2oMJQIxlCxjZGmuoc5m92lAvgLht/uMdf6bIWRAUrkf5U14sstg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7652
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi all,

I tested these patches as well, they were added to the most recent patchset=
.


Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>

Thank you,

Dan Wheeler
Sr. Technologist=A0=A0|=A0=A0AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook=A0|=A0=A0Twitter=A0|=A0=A0amd.com=A0=A0


-----Original Message-----
From: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>=20
Sent: October 11, 2022 2:12 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Went=
land, Harry <Harry.Wentland@amd.com>
Subject: [PATCH 0/3] Update DC commit sequence

This patchset introduces the basic infrastructure to change our display com=
mit sequence to make it more robust and flexible for handling some display =
features. Current, amdgpu_dm tries to commit a validation state directly in=
to update_planes and commit_streams. However, we want to avoid committing t=
he state directly into DC; instead, we only want to pass streams/plane poin=
ters into DC and let it manage the commit state entirely. This behavior is =
more future-proof because it keeps the state manipulation inside DC, which =
can benefit some specific features that might want to play with the context=
 state.

Cc: Daniel Wheeler <daniel.wheeler@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>

Aurabindo Pillai (1):
  drm/amd/display: Move dc_state copy in commit_tail after
    dc_commit_state

Rodrigo Siqueira (2):
  drm/amd/display: Add functions for new DC commit sequence
  drm/amd/display: Enable new commit sequence only for DCN32x

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  17 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 108 ++++++++++
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 204 +++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |   6 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  11 +-
 5 files changed, 333 insertions(+), 13 deletions(-)

--
2.35.1
