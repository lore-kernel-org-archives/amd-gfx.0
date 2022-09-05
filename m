Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 111A4ECAAD5
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Sep 2022 01:46:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2944D10E072;
	Mon,  5 Sep 2022 01:46:48 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4CED10E072
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Sep 2022 01:46:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhEfkCMzoDaKWsP9U62/YfC/Yee061FuIcN4UKLBXkNicyKm+o92z5NstwRWMz1qeBy7TjV54Bo+ktoVvnPtiZnU665CjHUSSQuQJ91ukS+A8gETg5/aG3r9w8bgRav4lz+FCdIqckh4efmAUvlVH6PCa30gSauD80x4yp4S3CsdXAqBAwEACPeZafewWe58zBW7kKCaeYXKVQLyxECgjcbPSSIXRaUPKGIU8WOSAkFWY0LfUUd5LAF9JNcYKBmDJA360O9+KOyBiAvjoOu+O8S5sOEorSmz0ahbM6zAU4H1zNvp/q7gXny72ix16Tn3YGbPR6mZEFKlNnlRJbev3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XrDrv+6AXK0mb4yYAY4y1mPcHRZkFBStiTXkQfg0Wts=;
 b=SdxknjyGOXKQlFYolHi0QaWR2uoxl038xqcJ4T1vgM4kucudLyn3nDoIvmd4hBgmVQWcnfVvm/5srR/xqdbR3N7PtmbIa2C4fUH7rHFSH2uEp1v3M28U9WzvTZnIc1cODo2aL0H/NDMzuPveaZPibKUZw46JmwuylFKLh6VUuPyIUhygLMQZ+QaHLp4FW7Z1rRfoaAAvWuXQ9Av2s165SekU1jZkOWsMy75wyK0Y+eUHm0YEgRm2U79Z9p/pIZIm9EgnPOp5PFSasppJ6LoRzqpJjFhvuOJmatssCb2Ip1e2wHWvNJdVuGyJWYSNecPujdc1LCE84nVlEHG/zLcEig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XrDrv+6AXK0mb4yYAY4y1mPcHRZkFBStiTXkQfg0Wts=;
 b=ZXRF3M/OtReYf7SkHMAopubZpgR/+l/pRaLTlajifpg4Es1K4pEKqCrk347/GtbMNNFzOawthSItKtKTVRqLNLvxOSrgu9hoKbmdV9A8SLpFbG9R/TXN/Ad+ShcROOHox8HXPfmPGZYXA3bOdVCcGGqvD4DIdB94jdVlZ0FvrF8=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by MN0PR12MB6366.namprd12.prod.outlook.com (2603:10b6:208:3c1::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Mon, 5 Sep
 2022 01:46:42 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9116:cb67:b4da:41b1]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9116:cb67:b4da:41b1%4]) with mapi id 15.20.5588.011; Mon, 5 Sep 2022
 01:46:42 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>,
 "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Match GC 11.0.1 cache info to yellow carp
Thread-Topic: [PATCH] drm/amdkfd: Match GC 11.0.1 cache info to yellow carp
Thread-Index: AQHYvdTQiViwZFIdEEa9gDF8/jJrY63LLOoAgAAyX4CAAAn8sIAEp0uAgAAFuQA=
Date: Mon, 5 Sep 2022 01:46:41 +0000
Message-ID: <CY5PR12MB636940E08DCF76C76A4070D2C17F9@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20220901072959.4085193-1-yifan1.zhang@amd.com>
 <BY5PR12MB387318D60C341DE66211E724F67B9@BY5PR12MB3873.namprd12.prod.outlook.com>
 <DM4PR12MB5248CC7BFD66675461C8C84BF07A9@DM4PR12MB5248.namprd12.prod.outlook.com>
 <CY5PR12MB6369CE86D66FA5010B56589EC17A9@CY5PR12MB6369.namprd12.prod.outlook.com>
 <DS7PR12MB60058FACB01936A5DA2030AEFB7F9@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB60058FACB01936A5DA2030AEFB7F9@DS7PR12MB6005.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-09-02T01:43:58Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=64ec50d8-0469-49d2-8aa1-29f13023105e;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-09-05T01:46:38Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: fce311da-7721-41d9-9f08-390ad524457a
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8edff3ba-d089-448c-dd65-08da8ee07b66
x-ms-traffictypediagnostic: MN0PR12MB6366:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /s3nDvKdtIfd3cvyjbY2GtGFskIN2rBDoJKb96Z1dMiEkDhf1CY++pML7sr6hIVZ6wRxwozKPzuXVJVBEkDbDpejJOelquS4heYkoZbE8rSr7sHOeB5joE0715et0h8qaxVF9P3wvJh/XLaGEm2JGto1gzVqcTGU1Ccx4fx992wclT8k5IC+T0U5ylH5rYl4WaM5MNmXl71/mUn64jtSgWrlOez+IqNp46R/3bNvp+Z7kUD1LfaKWiEdFTOsf2c+yxjIPx3Fc/i4+ZMUPIDtwDG7uA5e5lmJsrwkWbtb/O8uhcFRLM1FIJd38nNekonEwvCXUWcHVEU2M2y5w3xL9mh/OOhYksjRQgKHoAZK6BLHnP1Hf/fWjR+EzV+gTKg7/ctAQqX7dLTD9vykxCRFbvfPv1Y5VGlFXPh0ERpBeu/S4q76zY2fF4XVGRpSQlPjaRguZ62oLZ9J+0pbNsDFhAN4ct7YI66v8khKqMr9c5+VBP31kVQUzmlSaGkgLO4xEEZ7q/ftZ+GGEf9qYXQ/ZoYzYInn9i6xUHILpeJNXwLtioFs9+W3StQWn9xuJLji5m5kfcmjyBE25NnWB+NpzBbMD47YEh8yMScyt/mvBSmcxUwfs5rrNddu4vY9k9J+VJvQaWZbUFC2Q5oHHMDNiJnWqlPQIiV7HbUHO9yg6UbuF7vCBM11ZW6Bd8nPCE18Zpwl9rvZRlRMfhYa6njS6ryIHnXr+kFmRvs9T3sbEBADRxRi2zEkDSWypNmkhIAfd70fFaatpprjubhExw6Wpg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(110136005)(53546011)(52536014)(54906003)(83380400001)(41300700001)(316002)(6506007)(55016003)(9686003)(186003)(86362001)(33656002)(7696005)(478600001)(122000001)(8936002)(5660300002)(66946007)(38070700005)(71200400001)(38100700002)(4326008)(76116006)(26005)(66446008)(64756008)(66556008)(2906002)(8676002)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RNNg948METKY1hkQ+aQf7aWuIHlBHP6Ci+Vfb8a39GjaICYTRv+u12PS11zw?=
 =?us-ascii?Q?ficC2DagYI6b7ezERIhXu9u5dO0Wy78fMm8yVibmgpnf+97BFoP++RV9P9od?=
 =?us-ascii?Q?F6XwCM518oXqyTWrqtT+dzYWUbH07ATQKFuhSiK6OhDCtW3LJWLeZIPcWTtq?=
 =?us-ascii?Q?6X+SVXU3TQe3x8UJblT3UxEKHcYpDjAk7E0RPPKKF7vwp6uqWeGvBRcnQyUk?=
 =?us-ascii?Q?gp4zYHcDg0BTD0yibHHcQbul1xxNlASpfd6+FezWXDEtWp0VVylwz8LugYUu?=
 =?us-ascii?Q?m3xOa3Gq9mq8C3tCSETcAvblLe6mz4XQKdXL9qMs+fSMEe3xaScbjUAZzxQF?=
 =?us-ascii?Q?FgXLE0Z3cEjjey6Lr9ROeRhP1pnisiOqLY5KimT0L2szQc7seyN7Xjn6Kymo?=
 =?us-ascii?Q?jcyb5h8P5jhvyE4TXMnbqekq6KJP+7qD2BZfujwNWZHVidg3Ry1pm3kSyUcF?=
 =?us-ascii?Q?m3tAhe2s2s9GVp4Xdy3arKYlcmgJLt2M4o3eotE+uioZXycbF6546u73PGqi?=
 =?us-ascii?Q?9N6UVUPMbeGpFQCoH+hjXfTm/JLM11bztGGWsy08V0ICJODvMfIAIUAubblj?=
 =?us-ascii?Q?dQJnZBn2+Plf9/1qebP1BUJ9vZX+fwreoBSHmkC9E1ZI/0NVkRZf+/ZLlLVV?=
 =?us-ascii?Q?DfXxfF6pyyJWTX0hk0dSsdNFEDNO4rXuhnGCxklta3ha1+YOqvllBF64dk/g?=
 =?us-ascii?Q?9FO6XOi2aXQkiivzkThJesjMVkZT0LST+c2EImW9gq6pZcrTCheObMYIC3Pe?=
 =?us-ascii?Q?Vn0E40dQzSgKP0vpAWZ6FxcEVPwRWJHVpNOEKmgzbdqdQ/uMOy11BrJUehI6?=
 =?us-ascii?Q?yKTEux0MdKe16adjkCQT/uMCR81vP+I3whhc1vEVu9yyyiOP2kJ1T9ef0u2q?=
 =?us-ascii?Q?PNCBFKhdlf/757FGXTNsNlPl1+KMYFGMzld7OOTrhrzEt/JviXI6QxbLppNR?=
 =?us-ascii?Q?0CSlESk8TpkzILUEZkddAtMsFJv4Nbm6RTICKMynSRAA8TDmWf+sQ4SQyeeN?=
 =?us-ascii?Q?4aWqR8Y4QiBlPmnDG+8Ns7LPZhU0xg0KvwYGDG9WcXBmuBiihJHN4JTuBLaK?=
 =?us-ascii?Q?KOqzAGVGjJhdWS4Rq0MRyBhnhs8CniZ5GY8feT7hEYo7SkxEN+jWSASAc1d7?=
 =?us-ascii?Q?umdJqQsvcTYVoY4WoHktm96XIY1MPT1+FsgOtFeUAmKv7IvVk+Ku7RbUy9O5?=
 =?us-ascii?Q?E9pPt5sxH/Ptx7yKZEkA50Kjvk9K3dCywzcUwXrmIH0KllTURR3JIofjWKAb?=
 =?us-ascii?Q?650eo3R+MOcyYS8U5VytHX+g6meM04D+AxDdkleq+L0N83UH2VaOuxCPZ+08?=
 =?us-ascii?Q?qbxysEcnF5OjeRwaPJurD//aapoPLFns6dTkr9NKEdvjDxepSbh/2YXzbh19?=
 =?us-ascii?Q?mNXzev/aO4lG4sVRBDC149O2ZVkCvrLUs/zkD0rbIsAVERfbqqVBsaNseo5+?=
 =?us-ascii?Q?RB6M/qj5g9qxcdfI1o9I5S15yZce1jNuBd5DxEPcdwsXsY1jk/SnCMe7+9LG?=
 =?us-ascii?Q?jaIvjWJzmBKpn9oYYA/UMWNHC3W1jT8TcPtEQhlW3S2e2nJBZfG8Q9mEYq7e?=
 =?us-ascii?Q?W7gXCnm+6ysMdniV0as=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8edff3ba-d089-448c-dd65-08da8ee07b66
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 01:46:42.0191 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SzV4IGetM9eCZTtwFfmc7MPI9G2AKw263gtTQdKy6ERxOAkBFcaBxRUPeSMLHM8C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6366
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

It is actually a bug of discovery table which needs to be identified in NPI=
 phase. Hopefully we don't need neither dummy nor yellow carp cache info in=
 the future.

Best Regards,
Yifan

-----Original Message-----
From: Liang, Prike <Prike.Liang@amd.com>=20
Sent: Monday, September 5, 2022 9:24 AM
To: Zhang, Yifan <Yifan1.Zhang@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>; Hu=
ang, Tim <Tim.Huang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Du, Xiaojian <Xiaojian.=
Du@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Kuehling, Felix <Felix.Kuehlin=
g@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Match GC 11.0.1 cache info to yellow carp

How about add a dummy cache info for the NPI product in the default case an=
d notify user that's using the dummy cache configuration to make sure not m=
iss correcting the HW info in the future?=20


Regards,
--Prike

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, Y=
ifan
Sent: Friday, September 2, 2022 10:28 AM
To: Liu, Aaron <Aaron.Liu@amd.com>; Huang, Tim <Tim.Huang@amd.com>; amd-gfx=
@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Du, Xiaojian <Xiaojian.=
Du@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Match GC 11.0.1 cache info to yellow carp

[Public]

Hi Aaron,

Yes, the cache info are different. But this diff is intentional to workarou=
nd the discovery table lacks cache info in GC 11.0.1 issue. The workaround =
will be removed after discovery table finishes integrating cache info. Give=
n they already have a test version, we can pend this patch until they finis=
h integration.

Best Regards,
Yifan

-----Original Message-----
From: Liu, Aaron <Aaron.Liu@amd.com>
Sent: Friday, September 2, 2022 9:44 AM
To: Huang, Tim <Tim.Huang@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; am=
d-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Du, Xiaojian <Xiaojian.=
Du@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Match GC 11.0.1 cache info to yellow carp

[Public]

Hi Yifan,

Yellow carp's cache info cannot be duplicated to GC_11_0_1.

Different point to GC_11_0_1:
TCP L1  Cache size is 32    =20
GL1 Data Cache size per SA is 256

Others looks good to me=20

--
Best Regards
Aaron Liu

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of=20
> Huang, Tim
> Sent: Friday, September 2, 2022 6:44 AM
> To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Du, Xiaojian=20
> <Xiaojian.Du@amd.com>
> Subject: RE: [PATCH] drm/amdkfd: Match GC 11.0.1 cache info to yellow=20
> carp
>=20
> [Public]
>=20
> [Public]
>=20
> Reviewed-by: Tim Huang <Tim.Huang@amd.com>
>=20
> Best Regards,
> Tim Huang
>=20
>=20
>=20
> -----Original Message-----
> From: Zhang, Yifan <Yifan1.Zhang@amd.com>
> Sent: Thursday, September 1, 2022 3:30 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Tim=20
> <Tim.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Zhang, Yifan=20
> <Yifan1.Zhang@amd.com>
> Subject: [PATCH] drm/amdkfd: Match GC 11.0.1 cache info to yellow carp
>=20
> Current discovery table doesn't have cache info for GC 11.0.1, thus=20
> can't be parsed like other GC 11, this patch to match GC 11.0.1 cache=20
> info to yellow carp
>=20
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 24b414cff3ec..1c500bfb0b28 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1516,11 +1516,11 @@ static int kfd_fill_gpu_cache_info(struct=20
> kfd_dev *kdev,
>                 case IP_VERSION(10, 3, 3):
>                 case IP_VERSION(10, 3, 6): /* TODO: Double check these=20
> on production silicon */
>                 case IP_VERSION(10, 3, 7): /* TODO: Double check these=20
> on production silicon */
> +               case IP_VERSION(11, 0, 1): /* TODO: Double check these=20
> +on production silicon */
>                         pcache_info =3D yellow_carp_cache_info;
>                         num_of_cache_types =3D ARRAY_SIZE(yellow_carp_cac=
he_info);
>                         break;
>                 case IP_VERSION(11, 0, 0):
> -               case IP_VERSION(11, 0, 1):
>                 case IP_VERSION(11, 0, 2):
>                 case IP_VERSION(11, 0, 3):
>                         pcache_info =3D cache_info;
> --
> 2.37.1
