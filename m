Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49F6CAC592
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 12:28:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 400A810E47A;
	Mon, 15 Sep 2025 12:28:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sv7nQ8Hq";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010016.outbound.protection.outlook.com [52.101.85.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D87A110E47A
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 12:28:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofcTWrtFzV3xamA2/j+kcLvX2o4eEmFu0Fnac42TL9MC9KQ7UEQBj59eVnNB0SvGDEepzmGkYo3RsjyhoQmbJIxMEToDYIMF8RWjQnr7sB5Jqvw1WxIWMEv+RY3hv7BTJNDrA8y6QcBk8fV8xVzGT4PjPBJ5fphaIgs/e1lMg1cLk3dxChGQDh7R3jbfgcFkF2fbRXg5iN0RoaYZ76GMk3o3UIi9EjmrdMrdIpck+4XWpp+UiGO3Dou62MqgLcu8bDHO0VU2WnCDwmGJjuXqOdoGBp74Fd9KQhblTVq7rZzNpE4NOG/I517fA+5kHWSK52cdZAfhU5mIC9oN6a5iRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vP46m/snHt7f386A+9uI5act/gGT5vqa5t3lzbaDz/c=;
 b=hCDe7sLyTPVwkn/VbYtEHsWEyBWxxc+Z599Xs8yHSPBoPsnMPVlZ7GkxCYw10y/qao/O4gw+OU1KX0t0LcPm8O/AKyKstRcUnt2kZcVW+VdGavwUbF2PufH/FErh6BxvHHFxI5JtAuEVL/bl3eJrzCEDRCi5exl0ZF9acfMSTPMSfBvSU7l2/6BN+KXqJhv25t5w1n9loZplABy8vfOC3es9FLxvA6CNDnHYt7f2BlV2O9N95iTkBlkU3FNw2Ww5l2LUElobfMHg7AJg0Ds/VkT2GzMfjb1qNKsPIwCG2OqnO4CF8Ym9SWIYUruBJQ/K7tXj6oTDRZMQsl0IoFXHdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vP46m/snHt7f386A+9uI5act/gGT5vqa5t3lzbaDz/c=;
 b=sv7nQ8HqdZX2SHOPdO3TQHzioL4/lcdwzsxGyyF80p+21YGB3S7lzQygLRAY2XZDoAdeU+gJ44c/p/1HoZt8BCx13ArUL4UZY7/zXiv7yPUrsAl3mB14KiYJ5Gwqvzf8Pmk73clYZofxKUVN2upc6LN62+b6U8sjqC4reh3YX8o=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 MN2PR12MB4341.namprd12.prod.outlook.com (2603:10b6:208:262::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Mon, 15 Sep
 2025 12:28:03 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 12:28:02 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "Chen, Xiaogang"
 <Xiaogang.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdkfd: pass the PD BOs directly for PA
Thread-Topic: [PATCH] drm/amdkfd: pass the PD BOs directly for PA
Thread-Index: AQHcIGn1khhrH1c5f0qJu9TklhsZHLSLqDxQgAFT0oCAADqCUIAG/6Yg
Date: Mon, 15 Sep 2025 12:28:02 +0000
Message-ID: <DS7PR12MB60055172BFCBFD8A4F31EE0CFB15A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250908024021.1857440-1-Prike.Liang@amd.com>
 <DS7PR12MB600542F4CF8B3D69A06EB2C6FB0EA@DS7PR12MB6005.namprd12.prod.outlook.com>
 <589ee8d9-091c-4afd-b4da-f091cc717336@amd.com>
 <DS7PR12MB600554A97BEDE5F91393F6C2FB09A@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB600554A97BEDE5F91393F6C2FB09A@DS7PR12MB6005.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-11T01:30:55.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|MN2PR12MB4341:EE_
x-ms-office365-filtering-correlation-id: 7a9424aa-3ba2-418d-c623-08ddf45350a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?aXY4d3E1ODMvOHBwRC82WTJuL0tXWndIb2JzOHBIY2J6d25UdkI0aGI2aTFW?=
 =?utf-8?B?TnlqNlFReHVDS0hJdmdkTU9CUml2WlVxbUo5d2MzcEFwdFlxOXowbEthRmI3?=
 =?utf-8?B?REduWlMyenNGSCtCSHhtTFpyc2tLd3NnRklkejFDN243NzNPRUQ2ZHNtQkc1?=
 =?utf-8?B?YVhkV1lYd0ZzTDJqdDBncnc0QTRNSWlrYnBPRHJGN2RzRlM2YnR4RTEyZHZ6?=
 =?utf-8?B?WjZGY3gyWS9KSFY4MWxSMFBDVFJkMmxhR2w5WWc5RGk4NGhaa1dTK2VFRS9B?=
 =?utf-8?B?TVZVT09OSzlBWmMwTEtHcUdPay84NE82QWZvSGZvMkFyanJ5c0trWDNDOGFI?=
 =?utf-8?B?VFo3MVFQb2pUemxHTXFCQzl0TDFIMjhsOXFZbjZLenZmelpRbG1ncVcxZSt3?=
 =?utf-8?B?YjREQ3JBNTBEZVVYWTVsV3lHRWJyc1hMbUtUYVB1Y01hV3NFVGJLakEyNHRU?=
 =?utf-8?B?OUxsQmxNbGw5SXlMcFkrZ1RqdjdHVzRkY0tTT056c2IrMm56MzZqSXpNUnZ0?=
 =?utf-8?B?UTdJSU5OMjBNbTVONHVpL2hwT0NxZXpldG5sQk4yYURUYWx3U2tDcTRjY0ho?=
 =?utf-8?B?Q0lWUm1BcWw0b3dlU0NIWjlHMlpBNWRTeDFOR1EzSkplaVNpVEJWUVI2WW1o?=
 =?utf-8?B?THpaWHA2OVVYYVJZaGpRSTlZaVBKY1JXckthMUtVSGF1bEIrZFpnRm43QTF5?=
 =?utf-8?B?cjFObENDalBMdG5iakFsb2FzZWhhVEVoSGNMd2JXVjM3bjJKMnJudDhXZ2oz?=
 =?utf-8?B?TGluYjF0ODM0ZktHTE8yOUw2R1dpZEdBQjdDM3ZMTXpoNERFV2orYThwMFVn?=
 =?utf-8?B?ODI2VE1ELzhTSUJCYXJ0MkhqaE5zL3hyOEtmaFBNY1FsdGtaa1FuZC9ENHF3?=
 =?utf-8?B?OUFkZ3d0aStuVExmV2oyT3NDSDBBc05peEFVZVdDUXJ4eWNLdGtUZGZHUzFY?=
 =?utf-8?B?UUcrbXRUbDJPdkdtcHVJUXFUM0tJbGNMSStETHpFUTQ4bmxqYWZOajN1ZStB?=
 =?utf-8?B?WmtsNTIxd250MzlVL0syNmIzOGFDUXJTTEVlV0Rsd3ZrVlptRFRYaTR0QjVw?=
 =?utf-8?B?WWZIOEp6ZjdLWnd1RVdZTkRDbFBhbnhDWjJFWEtQbDJWYnA5eXRMZG9GNHJ0?=
 =?utf-8?B?VVNPWHBvcXR3NjZpTTYySlNWUFY0WmFRdVg2Y0I3UXJRblU4S1BxM1FuUlpR?=
 =?utf-8?B?bXlZLy9Sd2NGL3NxZXFxenozcEZlZHVXcjlneFFselQxdDVwK1pBN2FFdUNm?=
 =?utf-8?B?WDFNOE01TGRkN01aSlBBZy9tUU5qK3QxMkE0WHFBL0dlaGVDZ09YN05jTGVT?=
 =?utf-8?B?bmNiMUVYdHREaCtZSVhRUmZzR3Vkb2N6Mm52SlBpYmhJMFdpMitpenducmph?=
 =?utf-8?B?TUx1UjExMFU1VVA5dUhwaHMrQnNnV2tYamFOV0Jjd1ZrbjE5azI0ZzBTMklh?=
 =?utf-8?B?c2ZyNGhVa3htMGg2a3lCYWdJQ2hmM2dyOEpqMnFyQUJPZVhBTXBreGtYVitL?=
 =?utf-8?B?b01xVlJKaWxnT21ndFpZOWJmYnhQdlpiY2sxaVk3bkRuTzMyVkxSMTJ4VnhM?=
 =?utf-8?B?SE5qWW44VmkxYkNHanhBWlFTa1FSbDZsSnJ2dnlURVlBbWJ3SFNoL2RJKzZz?=
 =?utf-8?B?bHA3NUNLZVpJS2lvVkM5S21rckJEMlptYU0zMVAxZUNVZWxhcXlaL3R6enpV?=
 =?utf-8?B?U3BLUmp3Q3Y2NnZuVHJOK1p3Y0IzWTVOdVVDUE41STV4dXBBVlhodW00eVlS?=
 =?utf-8?B?cFFuK0lJYW1Cd2xrQVZKeGM1UVZqTmJpNlRHdU5tSmtTT1o3dytDTkFjbVB3?=
 =?utf-8?B?Y3VkWVJrTWVTMm5LcDRyUndyblJESlEzOEpsK0E3QU1yMGkycFpiTXJaV2RS?=
 =?utf-8?B?TDFKaVJyT1BoTHYyS1lTc3dYTlZIZnRQZTZ2OEhTWHpSc2QyZS9pZ0N1enZ1?=
 =?utf-8?B?TE94UVh2d0MrYnNMRU5iNi9sNGJtUEFGTk9SN1B0RnRrMG1vUjVSa0dHYU45?=
 =?utf-8?Q?SpaSy3zk0dK1oc8dg1VUKTDq2UCrQs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REVGSVpvU0JpZlZtanVIa2tQazZCdWpKWS8zblFueUhCUHZ2N2dvM0ExdHdi?=
 =?utf-8?B?STBPait6dUVaSTN4c0JWclNrTWl2dDlKZGdPQkJoSWk3K2t5eTVaWU4vUGVC?=
 =?utf-8?B?SWV4ZC9CNTYwanVGRndSdFBLbjZjU3R6cEZSb2Q4b29ZdU91Q1JkTFJCMFB3?=
 =?utf-8?B?cWJwaFFqVHlIZmIxeVNvcHJZMVZzRS9GYnZlK2RZWDZqZG5uVms1WHZzTVVH?=
 =?utf-8?B?OTRJWkxJSHdWa2ZiUmF6QTNhWWtKcm5VTHdicFB1ZVVMOUZRNUxMQmZHRGFP?=
 =?utf-8?B?OG52enprMHZGc1ZMQjlQT2VQeEpFT0lxRWE2YlBDeHhSSUhNMDVvT1lkUjRx?=
 =?utf-8?B?WHkyWC8xVXhMaWorNWV5Yi8reGo4M0RmeDdUNWN3WklaUE9Zd3lYb0JGTElv?=
 =?utf-8?B?akUyMEFyQ3NSU2cvYXNROGV4Si9NYW1rNWFpank3Z1pjcnZVY1l2M2RhVGpM?=
 =?utf-8?B?bzU3dVY3ZG1UU0pPbmZzdHhEalhtbzg1SGhlZE9OSHRKV3VaczRSQWNaa09o?=
 =?utf-8?B?UEpaS3pndEhoM1JDYWVDOTZiNURNWHUvaWxGQjVEYlFjc0F6d3V2Z2h3NUFH?=
 =?utf-8?B?UkhuRTJ2QkVJTUY3eEFscmVkZmxBcXp2b2lseWFIM29qbndvUVBITmNnTUM5?=
 =?utf-8?B?eW5tNmJxNk9UZVlGdWhCUkFUZFRzZ2d1NWRJVGNXT2ZJWm93ck9QajJDK0tq?=
 =?utf-8?B?ZHlBanJFTWprMkVyMG96OWFvOEgyejhuMXNUMHNodFdqNXRaODFTTXhoS0pB?=
 =?utf-8?B?bEtabmc3NGpydUhhVXhSQ2J4REpvOEFOazM2ejMvd3l0Z0ZTb0srU0VvZkRC?=
 =?utf-8?B?eGFLU0hxVmw0M05NbXVzZmMyZ3JrdWU1NjFzT1dCMCtYTkFLbVprd2hGdXFZ?=
 =?utf-8?B?TWNjSDBUMWlXZFpGR2VmaVBMRDlDeTNXc2IwYnQzdWZpemFDT3kvQmF3OVNV?=
 =?utf-8?B?aGZveFJ2OG0wR3RPMExmR2NNQmdNR215d0Y2Z2lqaHkzOG9LY1IxM0pmL0Fa?=
 =?utf-8?B?T2JqMk9wWHcvWnJmU3NkdE95bGFEMEpoSzJxZVFnbWRWVU9nR0hnbFVBOEJO?=
 =?utf-8?B?WVNwSitOeTcrYXlWV3JISk4zUzVxQkhmOHZaS2VqSk5lTGJhZlJNSUFNZzQz?=
 =?utf-8?B?aStJeGZFdHFOWWFJRy9sVUNiaUU3WG40NzY0MWtyQTFWcFpXM0d1cXNnMGRK?=
 =?utf-8?B?UndPR1BSaG53VGp6S1JHUE42bmlSTmp1NldpWGdWZXBPSHNkVDdNNGJSY1or?=
 =?utf-8?B?d3BrSSszZGdnb0VScVhVZ3EvNFNQcFdtM0loL3g5VWpzb2xoaHNocjFkNVll?=
 =?utf-8?B?ME10ZEdQd3FNbTFwb0hjMkNSYkNwMWI4TCtYU0szNk9ZYTJhQS9QV0YrOHZu?=
 =?utf-8?B?Y2hESGZmOUFhMXZnMTNyNlRCUmw3eU9qd0xqS2NTN2duMG5RbHBQMHBQODdl?=
 =?utf-8?B?MVpYYzV0aGhGQ1p5SkFlR09ha0c5WjVwM2tMSFUvVlhUaGZJaFg4aXpHRVg5?=
 =?utf-8?B?RXd0RDRQdnpBaG5SQVpTdGgrVjVJcXBmZnZ3aFdudUwraG9GczVTT3hldW9v?=
 =?utf-8?B?V25ZUGQvc2NrTGtnb1hqSm41RGd3SFk4c2w3ZFZjalV2Z3hzcS84c3FpSnFT?=
 =?utf-8?B?T1JjcTJpRHFCOGwrTytlbDF5YzhVNGd5MU1xdGlBeXUxNFUrZWpCMy9YNkFw?=
 =?utf-8?B?OXlDMUR1OFNQN1R3U0VSTjlyQldyU2RnQmtRa2JFajZOZG1mKzYrQitaRFQ1?=
 =?utf-8?B?ckVaTEdRaEhPYUJCVHhxTk52bjBxK1AzSGtsZ0RIMXhoaENHUzIyVkxwMnBH?=
 =?utf-8?B?dUlzWVcvc1ZPQ1hTai8yOVFTY2U1c2hlZGZNbjFxdEYwL0VEOGhmS0FVYy9H?=
 =?utf-8?B?MGZrTjFyRFNIazQwSVZuY3FacXY2QmJOdjVTVTRDWFdkVWdwUWc4NHAyL3Z3?=
 =?utf-8?B?b3UvN0ZrTHQ0NXMrQmErVi9pS2tiTVFNZU9KbFZNTXhjc1BDbUhKRnlrSElw?=
 =?utf-8?B?SEJRMEJaS1VJbDl2YXpVN09tT29CVklCZzN0QU83dHRQM3NKT2V2ckFKcWl0?=
 =?utf-8?B?Titheit5a0JWQ0JVU1VsK3puUlN0VFhGci9QMTl4SzFFOGZ3Q0IrS2hLZUZt?=
 =?utf-8?Q?pFok=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9424aa-3ba2-418d-c623-08ddf45350a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2025 12:28:02.8850 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ev/w+qbbsj4xkUF5Uk8/XnuEsYIuReLGC8eCtJXYFW/DzPBllFkWayimVNo3DSqE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341
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

W1B1YmxpY10NCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZz4gT24gQmVoYWxmIE9mIExpYW5nLCBQcmlrZQ0KPiBTZW50OiBUaHVyc2RheSwgU2Vw
dGVtYmVyIDExLCAyMDI1IDk6MzMgQU0NCj4gVG86IENoZW4sIFhpYW9nYW5nIDxYaWFvZ2FuZy5D
aGVuQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hl
ciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS3VlaGxpbmcsIEZlbGl4
DQo+IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIXSBkcm0v
YW1ka2ZkOiBwYXNzIHRoZSBQRCBCT3MgZGlyZWN0bHkgZm9yIFBBDQo+DQo+IFtQdWJsaWNdDQo+
DQo+IFJlZ2FyZHMsDQo+ICAgICAgIFByaWtlDQo+DQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gPiBGcm9tOiBDaGVuLCBYaWFvZ2FuZyA8WGlhb2dhbmcuQ2hlbkBhbWQuY29tPg0K
PiA+IFNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgMTEsIDIwMjUgNjowMSBBTQ0KPiA+IFRvOiBM
aWFuZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KPiA+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFt
ZC5jb20+OyBLdWVobGluZywgRmVsaXgNCj4gPiA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCj4g
PiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1ka2ZkOiBwYXNzIHRoZSBQRCBCT3MgZGlyZWN0
bHkgZm9yIFBBDQo+ID4NCj4gPg0KPiA+IE9uIDkvOS8yMDI1IDg6NDUgUE0sIExpYW5nLCBQcmlr
ZSB3cm90ZToNCj4gPiA+IFtQdWJsaWNdDQo+ID4gPg0KPiA+ID4gUGluZy4uDQo+ID4gPg0KPiA+
ID4gUmVnYXJkcywNCj4gPiA+ICAgICAgICBQcmlrZQ0KPiA+ID4NCj4gPiA+PiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4+IEZyb206IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdA
YW1kLmNvbT4NCj4gPiA+PiBTZW50OiBNb25kYXksIFNlcHRlbWJlciA4LCAyMDI1IDEwOjQwIEFN
DQo+ID4gPj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+ID4gPj4gQ2M6IERl
dWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEt1ZWhsaW5nLCBG
ZWxpeA0KPiA+ID4+IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPjsgTGlhbmcsIFByaWtlIDxQcmlr
ZS5MaWFuZ0BhbWQuY29tPg0KPiA+ID4+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGtmZDogcGFz
cyB0aGUgUEQgQk9zIGRpcmVjdGx5IGZvciBQQQ0KPiA+ID4+DQo+ID4gPj4gU2luY2UgdGhlIFBE
IEJPcyBhcmUgYXNzaWduZWQgYXQgaW5pdGlhbGl6YXRpb24sIHRoZSBwbGFjZW1lbnQNCj4gPiA+
PiBzdGFnZSBjYW4gb2J0YWluIHRoZSBQRCBwaHlzaWNhbCBhZGRyZXNzDQo+ID4gPj4gKFBBKSBk
aXJlY3RseSBmcm9tIHRoZSBQRCBCT3Mgd2l0aG91dCBhZGRpdGlvbmFsIGxvb2t1cHMuDQo+ID4g
Pj4NCj4gPiA+PiBTaWduZWQtb2ZmLWJ5OiBQcmlrZSBMaWFuZyA8UHJpa2UuTGlhbmdAYW1kLmNv
bT4NCj4gPiA+PiAtLS0NCj4gPiA+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9hbWRrZmRfZ3B1dm0uYyB8IDIgKy0NCj4gPiA+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4+DQo+ID4gPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYw0KPiA+ID4+IGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+ID4gPj4gaW5k
ZXggMjYwMTY1YmJlMzczLi5mZDljYmJlYmJkZjQgMTAwNjQ0DQo+ID4gPj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+ID4gPj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+ID4gPj4g
QEAgLTQ3Niw3ICs0NzYsNyBAQCBzdGF0aWMgaW50IHZtX3ZhbGlkYXRlX3B0X3BkX2JvcyhzdHJ1
Y3QNCj4gPiA+PiBhbWRncHVfdm0NCj4gPiAqdm0sDQo+ID4gPj4gICAgICAgICAgICAgICAgcmV0
dXJuIHJldDsNCj4gPiA+PiAgICAgICAgfQ0KPiA+ID4+DQo+ID4gPj4gLSAgICAgdm0tPnBkX3Bo
eXNfYWRkciA9IGFtZGdwdV9nbWNfcGRfYWRkcih2bS0+cm9vdC5ibyk7DQo+ID4gPj4gKyAgICAg
dm0tPnBkX3BoeXNfYWRkciA9IGFtZGdwdV9nbWNfcGRfYWRkcihwZCk7DQo+ID4NCj4gPiBEb2Vz
IGl0IGZpeCBidWcgb3IgaXMganVzdCBjb3NtZXRpYyBjaGFuZ2U/IHBkIGFuZCB2bS0+cm9vdC5i
byBzaG91bGQgYmUgc2FtZS4NCj4gSXQncyBhIHJlZmluZSBjaGFuZ2UgZm9yIHRoZSBpbnB1dCB0
byBnZXQgdGhlIFBEIHBoeXNpY2FsIGFkZHJlc3MuDQpJdCdzIGEgbWluaW1hbCBjbGVhbiB1cCBi
dXQgaXQncyBuaWNlIHRvIGhhdmUgZm9yIHRoZSByZWZpbmUuDQpNYXkgSSBnZXQgYW4gQUNLIG9y
IFJCPw0KDQpUaGFua3MsDQpQcmlrZQ0KPiA+IFJlZ2FyZHMNCj4gPg0KPiA+IFhpYW9nYW5nDQo+
ID4NCj4gPg0KPiA+ID4+DQo+ID4gPj4gICAgICAgIHJldHVybiAwOw0KPiA+ID4+ICAgfQ0KPiA+
ID4+IC0tDQo+ID4gPj4gMi4zNC4xDQo=
