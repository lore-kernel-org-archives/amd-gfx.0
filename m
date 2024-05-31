Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C6BC25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 06:36:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3052F1121ED;
	Fri, 31 May 2024 06:36:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RYHr1IaO";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A37610EBD2
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 06:36:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfazoXVaTEo8MRo5lnTt5L5y0vtJifDWIOBSl0Jo9+VzylRrBEb7ApPKI0DEOcHL1VZEWqkD8LgqDCHKu59ooNzV1IgZa3d/IzS6AlaR6aYFONDtuCrvUeksXDNEIeXyscZ7daM+y0XWURlyOXL7KEiDRhbCCJmlQy1TOX7PAXwFFB/4jKuGOyaczXkCgxV5ifTED4x2VrXxhgWDMQqpVihPtfbiklQGjzEluUMkmEw914UUu8JcGj0BIkeYFom9U6/VIesqdONC6tBDauuQWsgNzALfLI8mFlslirjjhIAENBqFuCufmzVVGJJD6a/6y4hHnuRS8OLKxzv1LUe8rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pivKIDTrtFoQcHmYWZs4ctMLlx8wScMCLbgR70Efh38=;
 b=OXPRxwWa3vJFVuE/dwoQjDB62St7K6tsn/lbSGy6JyZsvcdL89d16107Guwhum9vd2pF8aUnrpwPz9tTzIofBpluLdyrB/I4qkhcVahAGs+WmYALfleWjdqD1zoZH2GR8XiVlhRwgr6FPaIbQqrj72oHHF1Apk1Bi2o6pVxGk6OBbNIjczWktMbjv1hGsZIXTj4zgzqNIVuTq5cuCwTp4Io9fPUUTj8L/LvemWNWM8HQc+vtQYyEMjFcO5+Jdpp9UxxFxp32JWxd+hCEBKNBM9joLa8Az7D/oHzh6iM6BV72e9Ka+BBLUb50wE7rCmuoILLNxi2fnn/aVzF9dnKglg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pivKIDTrtFoQcHmYWZs4ctMLlx8wScMCLbgR70Efh38=;
 b=RYHr1IaOTL58g+uPXa8QZsrhURZQn77Feh8kjmOZTfEzH+BYhER0rsQ1kWuj+NT5i+BnveEHbmilJzIxn9fxELvApw98ppPlURt0UUJn8IJ1GNQlMZ5SySYzaMqcOcnrtc7vklhdyU6zDMyRhzQ4nOjOkIwn9CpWR31gQbOFIyc=
Received: from CO6PR12MB5394.namprd12.prod.outlook.com (2603:10b6:5:35f::19)
 by PH7PR12MB6393.namprd12.prod.outlook.com (2603:10b6:510:1ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28; Fri, 31 May
 2024 06:36:09 +0000
Received: from CO6PR12MB5394.namprd12.prod.outlook.com
 ([fe80::641f:33ef:d412:4080]) by CO6PR12MB5394.namprd12.prod.outlook.com
 ([fe80::641f:33ef:d412:4080%5]) with mapi id 15.20.7633.017; Fri, 31 May 2024
 06:36:09 +0000
From: "Zhou, Bob" <Bob.Zhou@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Fix the null pointer dereference for
 vega10_hwmgr
Thread-Topic: [PATCH] drm/amd/pm: Fix the null pointer dereference for
 vega10_hwmgr
Thread-Index: AQHasaJn34q/9bPve0+MwJG2MDMSI7Gwz62AgAAV1zA=
Date: Fri, 31 May 2024 06:36:09 +0000
Message-ID: <CO6PR12MB5394F1B7329D53622D2CF9DA94FC2@CO6PR12MB5394.namprd12.prod.outlook.com>
References: <20240529082956.94945-1-bob.zhou@amd.com>
 <CH3PR12MB8074310272C4361ADDFB1274F6FC2@CH3PR12MB8074.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB8074310272C4361ADDFB1274F6FC2@CH3PR12MB8074.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=cb34c43a-d93b-4906-af8e-d061b4c52478;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-05-31T05:11:27Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR12MB5394:EE_|PH7PR12MB6393:EE_
x-ms-office365-filtering-correlation-id: e1bf5919-16dd-4626-361a-08dc813bf4fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?iso-2022-jp?B?clVuRU9GMnFhNHkwT2JjS2diMHlrSXVBN0o5V3MwK21BK3RxZ1RCK0pK?=
 =?iso-2022-jp?B?SUJMbDNoNDNMNnd0T1l1NGlndjg5SlloMmJTUjJvc2ZudEhGZzdsRnky?=
 =?iso-2022-jp?B?NHdGcnBOVFVjanIwYjlzTis2VkV3MWpmYm5hRnlNQzQ2MkpmNDd1a3Ix?=
 =?iso-2022-jp?B?amNjbjRFczgrb0VpZ05ROG5pdXNza1R5YVdNUFVWZzVxUXB6OGJ0RjdB?=
 =?iso-2022-jp?B?SC9nWUlWdkZqV25OblV0NEc5SUxFZDNveWJKMStvU1RBZVdvaFFQeEUv?=
 =?iso-2022-jp?B?Y25ZR1h5NlRuOFo1NGRWTDRyWkIraEI1WEI1S1Fnem12eUl3eVczZFZv?=
 =?iso-2022-jp?B?R0tsYThDSFd1ek5tTURxQkh3aXNSMTJzWitiUFlRMGZlZEtHZCtVc2JQ?=
 =?iso-2022-jp?B?Yjh3MDgzck9xOU1OR0VhMDZRZUlXN3R5NjBjK1VVRWhGRkYrem81STVC?=
 =?iso-2022-jp?B?WmVCVGtMVmU0djhEazY2dE9mVHdEbUM4RlJ2OUh2RHNCcUd0aWpOUmJS?=
 =?iso-2022-jp?B?WjIwa3FjeWxwbHgzbDhxYmtBMys1b1g2Q0VJamVHajhDR29mT2dOWFRW?=
 =?iso-2022-jp?B?aStlcHBnRGlVVUNyVmsyTjBJVXAxNnp4ZEIvTDQ2TzhzQ0ZiNElyQWZt?=
 =?iso-2022-jp?B?LzZLUzl3WTZac0JDemd1bGJwcWQ1S3hHM2lBWkhtMkxrMGpOZEJaZmVr?=
 =?iso-2022-jp?B?a1JNamhhMStvcW1mZ3RjMWl1ek41c0F6SUlsdzROM2ZvQ2pkTWI0azBH?=
 =?iso-2022-jp?B?cDVPbzFKSEsveDA5TVhETDFVNjdhTkgxUEtjKytxM3J2ZDdzQ1Z4cWc1?=
 =?iso-2022-jp?B?Z0xwNGNBM3g1VFcyOXJ6MVhJcUE4QzFTVjYySjBaS1pVOWtEOVRBRmlI?=
 =?iso-2022-jp?B?YW5TMVVWSGhxanVodEc3SC9DREZjSEc5ZFZ5eHFqWkwzdUFxS3ZMc3hN?=
 =?iso-2022-jp?B?aW5RTGxjM3lzTzc4WEd0K2k5MnZ5Y1FHSEdweEkzbDQ5L0FCWCtFWmZS?=
 =?iso-2022-jp?B?eHJQYmdHM1VNU2tKTlppVE1QRzVtd2lCS25EMlhFVEFKclBRcE81aWc2?=
 =?iso-2022-jp?B?d29nMS85d1Vsd0NYNW5jdGJxRUlsSjlkdFJHakZqU3Y4SjNPUld1K2NQ?=
 =?iso-2022-jp?B?aVIwSDNnZTF2SisxM2dvcm1PWVV2VTdraEY0eGlJQTNxcTJNeXYrOTI4?=
 =?iso-2022-jp?B?WTBWNWpsclkxeW16YkNtTTNQTmxFZlFHdUk3OVFxSUgxRTdLZlh3NXZK?=
 =?iso-2022-jp?B?Z0FHdzBkdnFLMjBKNFJNRmhHYXBHdmc3VUFOYzJQN0lKMU54clFFVjlx?=
 =?iso-2022-jp?B?MHNoalZIR3Robk9sRW1ZRkhLa0VIbG0veVZVQXY1S1cvbjBQeTU3V1BO?=
 =?iso-2022-jp?B?MDkyWURtRXhOQXpGU2ZUejkrV1htbkNTbWlyUXF6SXc2OWY3OUZQUzZD?=
 =?iso-2022-jp?B?QnVIVHE3bGozZDZiQTl0WVlET09XaWlXY1czd2NEb0N0bUI4dWFOZ3RD?=
 =?iso-2022-jp?B?a1l6cVJySjFWWlRJZFkvcW5uekZ0bUFKWU5sbkZla1lMSmYwT0hGaitr?=
 =?iso-2022-jp?B?ZHpRYkRlZGt0enVTTXkrbmdPcWp6bm8xRjVQNFZ0OVJWZkNqUmdENjZF?=
 =?iso-2022-jp?B?SGJFcUZYR2ZkOVdjMGJ6WnVzZmc3WitpWHFrd3lYejh0OW9UbVJDbDJF?=
 =?iso-2022-jp?B?ZThuQTU5ZlBMaUFrZGNyMG9oN3NraGYwYkU2MTA0S2VtcE4rQ20yMkVp?=
 =?iso-2022-jp?B?M1UvTGt3amNWcGY1MW12QTM5QjdqSlI1QUw2eCtLOGorWkoycjNoM2dF?=
 =?iso-2022-jp?B?SDlLZHNxeWwxVkt6TEwvdFA3SWJHSCt6aEJQNjhuK2xZTDdtL0pEdEhj?=
 =?iso-2022-jp?B?VGFEWllYU296QjU1QUNzN1k3ZFkvVTJ0MmlEelMzd2pPZnJmZTRtWGg2?=
 =?iso-2022-jp?B?L24xODgzOWpzazJ1ZnBMR1RoRElOZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5394.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?ckMwZVNZRTdoTllWR0FOeCt1b0d0VGFmbjZDdTU1ZHlJbXIvU3Z6cXJ0?=
 =?iso-2022-jp?B?cWdpQy9xZ3dLaFppbWJHdm9FSW9oMDBOSzhBM2FwNlQyN2xnRmRJVVlH?=
 =?iso-2022-jp?B?aWFWTHZrb01HQklrdkg0dk5TL2grVDQ5TUxwMThwckZrN0VxNlQxUkVD?=
 =?iso-2022-jp?B?TE1ROGhEbTFiOVVEbVpzVk1HV0xxQVl6QUc3Z0FzeS8zd2xqQXRVVUNV?=
 =?iso-2022-jp?B?RStIQWQydERmUUhmdjBIMmpHS3BzcE5VZU55M1A3djZGSzM2amdQUVcv?=
 =?iso-2022-jp?B?WVpKNVM1V0NyZkpPK1J5RVBmQTcrVGdyVWRMVzhDeEwrb3NDNENVd3Z5?=
 =?iso-2022-jp?B?Qm53RlhqZWxLbjlhRWNDbU45TUxnRXVZcDdjLzdXdmNQRHArZFJ3dnI3?=
 =?iso-2022-jp?B?RHZzNThUOThIbnFtUVQwOUZIYldoMXBBNzZRcXRQN20vd3JzeUMwbGJY?=
 =?iso-2022-jp?B?b085TVlrT2IrTTlZcDVDRFZFRVFMSDRla0dQbytWWStLS0xPWkNTbEpU?=
 =?iso-2022-jp?B?TE1NaG9sRlB0WTdYcVJyNUZhMm5oSXRxRXNwVlZIL3c0bENxNm45STIy?=
 =?iso-2022-jp?B?eldlQ09RRGhNejc0WWdHMHpmaTh1ZFpGS1NMMnpJbHdndWN1N1djdkZH?=
 =?iso-2022-jp?B?cFdWazFyaVJvME9oWkRFa1lIMHlLV1p3ZHhPUTEyYU80SDdmZ0lGZjQx?=
 =?iso-2022-jp?B?cVd5azN3aHVnMWtzYVlHL2NrVFBubG03MWFoaDlBNTljanBxQlp3NnVY?=
 =?iso-2022-jp?B?TUd5bkt5TFJFODRaTWV6aDU0U1dYd1FRK1pDL3ZKNVo1SEdjYmRlSEkw?=
 =?iso-2022-jp?B?eU1aQUpvYyszTXRGK1ErRG1RbEx5WFhHZTRhdGVmUWRYMWVCM3VWVXhi?=
 =?iso-2022-jp?B?YUUrd2U4M1ZGY015Um1DU29NcUt1WjRhMUdyVFNEQjdYT0VMMERGOXEr?=
 =?iso-2022-jp?B?ODMrTUNvR2FwU09CaExvM1pFd0RmMS9wc3krdnVML0xuai9RSVRhNGlS?=
 =?iso-2022-jp?B?VkpVUDJudkgrWEJMMUwvZ1c0Q1JvNTY2RjJ1cDJOajgzQUQ2K2N1dWlD?=
 =?iso-2022-jp?B?ZFR2dzRUcXlENkNNTFg5N2h2VnFGK3pFb2NocWFvZ0pUUGQ5Tk9jQzZz?=
 =?iso-2022-jp?B?NGUvcmQycVUwZnpEZmYzTGtKU1hBdy8wODQ1SXA4ZjBtOHFvQzVMZHYr?=
 =?iso-2022-jp?B?ZzZ5NjY5U1d4djJpdHcxYXpwTCtlaXVjc3Rwa3ZjKzl6V2RERjdML1hl?=
 =?iso-2022-jp?B?VFcwNnpzKzVRODBrNkE3cTE2WmFPSTlXRm1hWGN1eWJKVk1KN08wM3pj?=
 =?iso-2022-jp?B?b3pnUWJQODJLb3dnSDgrbVFFUGYwbXhVY0RSK3lBdmJxRTY4RTdMVVd1?=
 =?iso-2022-jp?B?eEZuMWczdnZlTmtQQThDZm0wbHNIWEk5NWdPbVl1eS9ZVDRReTdXLzV3?=
 =?iso-2022-jp?B?VjhodHlCYjhMVWIwMUZEWHVSbGRlTVQ2djJHVXV5VFNCbUFaeFEwcEZn?=
 =?iso-2022-jp?B?MWNwdXgxcThzM0luemg0QlovVHVsT25kcXRrRlVxMnh3Y3RSVTh0TWVt?=
 =?iso-2022-jp?B?YTdlbExhei9rck9zUmVBRFBtODc0V1JvdXRXa3RJK1A1aHgrU2FYQVcx?=
 =?iso-2022-jp?B?aUt1Q05BbFNYK21rb3YzVGhPcnhISHYwZnhRYnBMYmFyekdoNWwvY2cz?=
 =?iso-2022-jp?B?b0ltRytpODNQalFiYWFTVXRGNmV3MlpqTUZGMXVxdE1ueGRNWnpyNEQ4?=
 =?iso-2022-jp?B?TkFveEdjRjZVdE43b3NKZC9qaDl0VzErVVRaVC9uZ0t3eHZlS1cxaWg2?=
 =?iso-2022-jp?B?N1FSUmxNem5yOUcwUjRGLzc1c0RzaEFNUWh4SXNuOWFxYnNZcnkxcTJK?=
 =?iso-2022-jp?B?aXhyZUlBOEJIUG1TNjBmeTdwVm1oMDZPNlovSjMzY2l3Q0ZraHdwdVlm?=
 =?iso-2022-jp?B?U29rSG9wT3RHY1dvSjBVTTBlRVZ2eHg0MytpODhNMUJBSmhKanNFK3h3?=
 =?iso-2022-jp?B?YkIyYks5UktKUDZ0QUs5aElsUEprYUQweis1cng0NHQvbVlqOGZKYlZq?=
 =?iso-2022-jp?B?SXl4K1hOUndYSU4rSCtHcUNqUGVINkJ1eEVQcTB4T0JTM3Z0amJ2YWVi?=
 =?iso-2022-jp?B?RndUTzh5NUVLR1J1MHFhU1ErbnNuYlY2Z29UK09LeFkzdmdKb3VYcHIv?=
 =?iso-2022-jp?B?amNYazE3UWJncjNQN0ZNMEk3emJheUpVQ0tCakp1cVBZQXZ4SzBHQkxU?=
 =?iso-2022-jp?B?b2RMUHZjZHZZK2Q3c2M0M2UrSGFSNG1xbz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5394.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1bf5919-16dd-4626-361a-08dc813bf4fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 06:36:09.2387 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W0uUd+Xj32r0ZwKDLvbRTrlqa8j1i2gGt34WdgFJn9dIVHRfUEC4YCH4RTOKbTzo4oau/e8cTsuxyEW5IYCRvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6393
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

[Public]

Thanks for your suggestion, I will send the next version patch.

Regards,
Bob

-----Original Message-----
From: Huang, Tim <Tim.Huang@amd.com>
Sent: 2024=1B$BG/=1B(B5=1B$B7n=1B(B31=1B$BF|=1B(B 13:15
To: Zhou, Bob <Bob.Zhou@amd.com>; amd-gfx@lists.freedesktop.org; Zhang, Jes=
se(Jie) <Jesse.Zhang@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Zhou, Bob <Bob.Zhou@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Fix the null pointer dereference for vega1=
0_hwmgr

[Public]

Hi Bob,

> -----Original Message-----
> From: Bob Zhou <bob.zhou@amd.com>
> Sent: Wednesday, May 29, 2024 4:30 PM
> To: amd-gfx@lists.freedesktop.org; Huang, Tim <Tim.Huang@amd.com>;
> Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhou, Bob <Bob.Zhou@amd.com>
> Subject: [PATCH] drm/amd/pm: Fix the null pointer dereference for
> vega10_hwmgr
>
> Check return value and conduct null pointer handling to avoid null
> pointer dereference.
>
> Signed-off-by: Bob Zhou <bob.zhou@amd.com>
> ---
>  .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 38
> +++++++++++++++----
>  1 file changed, 30 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> index 6524d99e5cab..0f94564b4adf 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> @@ -3436,16 +3436,20 @@ static int
> vega10_find_dpm_states_clocks_in_dpm_table(struct pp_hwmgr *hwmgr, co
>       struct vega10_hwmgr *data =3D hwmgr->backend;
>       const struct phm_set_power_state_input *states =3D
>                       (const struct phm_set_power_state_input *)input;
> -     const struct vega10_power_state *vega10_ps =3D
> -                     cast_const_phw_vega10_power_state(states->pnew_stat=
e);
> +     const struct vega10_power_state *vega10_ps;

Not revert xmas tree notation if change this.

>       struct vega10_single_dpm_table *sclk_table =3D
> &(data->dpm_table.gfx_table);
> -     uint32_t sclk =3D vega10_ps->performance_levels
> -                     [vega10_ps->performance_level_count - 1].gfx_clock;
>       struct vega10_single_dpm_table *mclk_table =3D
> &(data->dpm_table.mem_table);
> -     uint32_t mclk =3D vega10_ps->performance_levels
> -                     [vega10_ps->performance_level_count - 1].mem_clock;
> +     uint32_t sclk, mclk;
>       uint32_t i;
>
> +     vega10_ps =3D
> + cast_const_phw_vega10_power_state(states->pnew_state);

Why need to change the definition of vega10_ps to two parts? It may be enou=
gh to only add below check and change the sclk and mclk.
> +     if (vega10_ps =3D=3D NULL)
> +             return -EINVAL;
> +     sclk =3D vega10_ps->performance_levels
> +                     [vega10_ps->performance_level_count - 1].gfx_clock;
> +     mclk =3D vega10_ps->performance_levels
> +                     [vega10_ps->performance_level_count -
> + 1].mem_clock;
> +
>       for (i =3D 0; i < sclk_table->count; i++) {
>               if (sclk =3D=3D sclk_table->dpm_levels[i].value)
>                       break;
> @@ -3748,10 +3752,13 @@ static int
> vega10_generate_dpm_level_enable_mask(
>       struct vega10_hwmgr *data =3D hwmgr->backend;
>       const struct phm_set_power_state_input *states =3D
>                       (const struct phm_set_power_state_input *)input;
> -     const struct vega10_power_state *vega10_ps =3D
> -                     cast_const_phw_vega10_power_state(states->pnew_stat=
e);
> +     const struct vega10_power_state *vega10_ps;
>       int i;
>
> +     vega10_ps =3D
> + cast_const_phw_vega10_power_state(states->pnew_state);

Same question as above, maybe it is enough to only add below check.


Tim Huang

> +     if (vega10_ps =3D=3D NULL)
> +             return -EINVAL;
> +
>       PP_ASSERT_WITH_CODE(!vega10_trim_dpm_states(hwmgr, vega10_ps),
>                       "Attempt to Trim DPM States Failed!",
>                       return -1);
> @@ -5036,6 +5043,9 @@ static int vega10_check_states_equal(struct
> pp_hwmgr *hwmgr,
>       vega10_psa =3D cast_const_phw_vega10_power_state(pstate1);
>       vega10_psb =3D cast_const_phw_vega10_power_state(pstate2);
>
> +     if (vega10_psa =3D=3D NULL || vega10_psb =3D=3D NULL)
> +             return -EINVAL;
> +
>       /* If the two states don't even have the same number of performance=
 levels
>        * they cannot be the same state.
>        */
> @@ -5168,6 +5178,8 @@ static int vega10_set_sclk_od(struct pp_hwmgr
> *hwmgr, uint32_t value)
>               return -EINVAL;
>
>       vega10_ps =3D cast_phw_vega10_power_state(&ps->hardware);
> +     if (vega10_ps =3D=3D NULL)
> +             return -EINVAL;
>
>       vega10_ps->performance_levels
>       [vega10_ps->performance_level_count - 1].gfx_clock =3D @@ -5219,6
> +5231,8 @@ static int vega10_set_mclk_od(struct pp_hwmgr *hwmgr,
> +uint32_t
> value)
>               return -EINVAL;
>
>       vega10_ps =3D cast_phw_vega10_power_state(&ps->hardware);
> +     if (vega10_ps =3D=3D NULL)
> +             return -EINVAL;
>
>       vega10_ps->performance_levels
>       [vega10_ps->performance_level_count - 1].mem_clock =3D @@ -5460,6
> +5474,9 @@ static void vega10_odn_update_power_state(struct pp_hwmgr
> *hwmgr)
>               return;
>
>       vega10_ps =3D cast_phw_vega10_power_state(&ps->hardware);
> +     if (vega10_ps =3D=3D NULL)
> +             return;
> +
>       max_level =3D vega10_ps->performance_level_count - 1;
>
>       if (vega10_ps->performance_levels[max_level].gfx_clock !=3D @@
> -5482,6
> +5499,9 @@ static void vega10_odn_update_power_state(struct pp_hwmgr
> *hwmgr)
>
>       ps =3D (struct pp_power_state *)((unsigned long)(hwmgr->ps) +
> hwmgr->ps_size * (hwmgr->num_ps - 1));
>       vega10_ps =3D cast_phw_vega10_power_state(&ps->hardware);
> +     if (vega10_ps =3D=3D NULL)
> +             return;
> +
>       max_level =3D vega10_ps->performance_level_count - 1;
>
>       if (vega10_ps->performance_levels[max_level].gfx_clock !=3D @@
> -5672,6
> +5692,8 @@ static int vega10_get_performance_level(struct pp_hwmgr
> *hwmgr, const struct pp_
>               return -EINVAL;
>
>       vega10_ps =3D cast_const_phw_vega10_power_state(state);
> +     if (vega10_ps =3D=3D NULL)
> +             return -EINVAL;
>
>       i =3D index > vega10_ps->performance_level_count - 1 ?
>                       vega10_ps->performance_level_count - 1 : index;
> --
> 2.34.1


