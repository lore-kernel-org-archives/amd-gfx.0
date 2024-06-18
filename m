Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970A7C2BA15
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 11:08:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14DDB10E108;
	Tue, 18 Jun 2024 11:08:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pMR9cYGw";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09AE810E108
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 11:08:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nX8h4+IzayBr8AQiTp2vBP5b5BjWh8dGHd8XpKzKpdsFk2BBeyNBmF3m7l2LxdazfAAmTbRE1UvlWdW2eR4YTN5PRStU7wU8zSr3r0mWMAfH5iA+G+xdD/ggSAK/wXvOb4NDC+iqPLi/JMLzJvFXIovvFoJgbA6SZZRa+cX6kwL/4i6WumRHM/QNJKjHDnh6jQrqOMIFrt5DZ+gi5frwA7iObkiIVukMCOztH4FG22a1OrFczR+q4ntZnEycBkFvJXzSmvaEtubfdhl2x3YUTb1gHCmqj2qX1/6cOR6g8oRwaKs/4QTjwnhcSrE1vzG8RbgUdOiLAB1XYrCwrBra3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTIW4Wktu6zgDdnsU4eHMDsznQzE4wfP0IS3fNeJZC8=;
 b=fIi0gDKLx7Ckr9X3M+AbBj+5r6re5FgyxlJuYosYILnDUtkYO16udcbEqyGwoxCwdg6D4aI2WdQhlOzgpFOGxdeZzBzMr3vBpoXrptKhHCkfVDCcqzTTfzbrExmVeKIfD9B8j8wC76B/c1rSTkx7LqLDiGkt8P/heJ1xvkElGdl5C+KqCnEnSLRItTLk9yjkO1ac6GUUbg9iVT0ZdQt5MH+dSOMA0CSiUbm3A6EVoBBIqvi53qPPDO0ccSCttcNv6PTXQKeC1W0+jI0lp/EtKT7X7U/DDMToT0GQ42Gld/SweGa37H3kXLbyNw3Nsv/eUuvjJbc+CT3+PWjsAOt2rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTIW4Wktu6zgDdnsU4eHMDsznQzE4wfP0IS3fNeJZC8=;
 b=pMR9cYGwMUVRimoWvONesyMLkXvSV/BjOozG6QFaowsvbkfuJ0bx1XABmx2przY8NXlkv379M6JBT5pHm5kUis8OLgW0S0I7Ffc7AgYa9bl+7AdUGZlFm+skXSd61RWxx2eGYu6jH2RTdLMd5+gurhpL382rNw3KbN0F8wRZ/BE=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by CY8PR12MB7315.namprd12.prod.outlook.com (2603:10b6:930:51::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 11:08:42 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a%6]) with mapi id 15.20.7677.019; Tue, 18 Jun 2024
 11:08:42 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH 4/5] drm/amdgpu: add completion to wait for ras reset to
 complete
Thread-Topic: [PATCH 4/5] drm/amdgpu: add completion to wait for ras reset to
 complete
Thread-Index: AQHawUmZh+cnncTiokiQg6Zfrfp0irHNTJuAgAAQDmA=
Date: Tue, 18 Jun 2024 11:08:41 +0000
Message-ID: <CH2PR12MB42153B70D0E1F0EC8719E371FCCE2@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20240618063359.304293-1-YiPeng.Chai@amd.com>
 <20240618063359.304293-4-YiPeng.Chai@amd.com>
 <cb616e09-aad2-433a-a7d6-a6a322687d17@amd.com>
In-Reply-To: <cb616e09-aad2-433a-a7d6-a6a322687d17@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=379ae3b8-5d07-4ad4-97cc-b2c6918618ad;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-18T11:06:50Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|CY8PR12MB7315:EE_
x-ms-office365-filtering-correlation-id: 2bd81879-8ea1-44ee-4cbb-08dc8f870369
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?cTJxcWRnVnJ6cTl4eTVTSGFScG1mRjd2bFFiRG42RkUwencvdDZENTR6UW03?=
 =?utf-8?B?VnZOd0VUd2tLeDVVSWZNK1A0VTJHZHFVTUFMMzRXaWRnbUNpOXZvbzV0VGRN?=
 =?utf-8?B?RXNjby90MWlHczZoZWpoR3V6dyt6YkZuUVdGM3JiblgreDNMeE1qWU9RTGJQ?=
 =?utf-8?B?Ym50bEc0SmNFQ2l6dkdhUFZLZFNEWXpsWi9OSVhQRTlwVTdtWHRPeHluK3BF?=
 =?utf-8?B?Rld4YjdIT2ZoYjNnWWhaOW83bDZHNnpNdVVRMEVEemVsZFhqdE1CR2wxRklK?=
 =?utf-8?B?cW5lZG9HNlA3RSt5M081WXR1ZmhMSUlZUnhJR2NFZEh1bUNybnNKeDJxTENL?=
 =?utf-8?B?NXFBMElmYjFVMmpKWTlDMDBwVmJQeTZ5NWs1eG5kWktzSmpuWmcvemt0SHU1?=
 =?utf-8?B?YjdPZDRIQzMyR3pYeURQSXNkZTVZNFVrcjBPdzdtRERkekdLalRrUzRQMHVv?=
 =?utf-8?B?TXZLNDFpVHVRQWZxakw1NVJGaUE0ZkNPOEh2c1BZendSWGJONGZseGtDblg4?=
 =?utf-8?B?T3I3SHg0SzAzZ1ZmbXRKTTVCOXlVRE9aUXZLbFFyWDFXK3kxemdWc1pCL2g5?=
 =?utf-8?B?Q0wvZ1VJQ1FhTDk2TXJUaFRvcmx0WGtUQkV2VVVEZUcrQXphNmhyeE5mUnVH?=
 =?utf-8?B?K2szbjlXQS83ZGh3MCtOWkVlZE9yQ3JrYTdxTXRXeCtDK2dDMi9MVHQxY2NR?=
 =?utf-8?B?bDcyV1dmOTRlNFVsQmwwMldqS0J5QlJTa2tNM3BVdHNyMVZKaUtpdENXQk9I?=
 =?utf-8?B?YlgwOFFMS0ltelZZbEkwZVlYWkk3aENVb01qL0NPN0RkSFZTVzhOUXlMNDBC?=
 =?utf-8?B?NVF2WVRJVXB1ZEJ6WWV6bjJmbndqajZ1NndTQUtKWDVZNld5cGRuajRxY0xl?=
 =?utf-8?B?QlNuaFlzM0o3OFc3d2JZUTZFS0ZDc0ZsdVpCcHJkV0g0a2lTUGUzWGpsZmlP?=
 =?utf-8?B?ak5yT0JRNkJPclZmbWpzWCswVmc1V0gxdytZVjV4THozWlJlSWpjZjlaaC95?=
 =?utf-8?B?K3k5L0EyNEw5UEhZa2tmeSt5dHFNSkMwa2FzZ2pQclhtZm8xVTNsVDRlcXo5?=
 =?utf-8?B?TGtXL2hycWowdWx1V3dQQjhTVUUzZlB3d1NFQTdSZmZmTFJETU9jS1o2ZzB3?=
 =?utf-8?B?MDA2eDlWeFRZUVNFTmFlRDU5bDJtUGNWeEJvaWtPQXQzR2k1S2dGd3dYZXFx?=
 =?utf-8?B?WEV3eTNqMmZqcXc1b2liNVNSRStSSFhkdnREZFl5NE95M1F1WEpFWVZ4Y2p6?=
 =?utf-8?B?MnFjNDlERWVsdytWTUszK2tENTIzOTVubEdNamJZa3hwRjJsaEFCTEJ4SnFB?=
 =?utf-8?B?eFdlaGgzQlRYMm9PVmpLbm1PWGtnOE9PTU40RHJCbTdiZHNyUE1MclVNMEVM?=
 =?utf-8?B?elduTVh0UVBZNW55M1F3U1dTVVRLekFYeGI1S3VxTXBXZmV2dDRKUTNXeTVL?=
 =?utf-8?B?cUhvaWpvMjdWbktJR0M5a0xTRXdDeE9LUnZuZGR3cmRpdUMybWMrcGd3Kzlw?=
 =?utf-8?B?bWNINnpNNkNUUE8zSHpZSzVXUmQyL01jSHc3d0h4OGdBbzEzdnZTUDBpUlNY?=
 =?utf-8?B?TGZ1U2YrZzBFZXI0Z2ZZTmtVOFZIa05acTg1ZFFTZWZpeDFrL1JnZWwyYUZz?=
 =?utf-8?B?U1Qyd2FqMTU5Vzk3czZZRVFzV3lFTmhodFhxOVdqT3ArVUZuWTBnNTY5Vmhq?=
 =?utf-8?B?a055L2haRmI2azdGWUZ2OTVHNHBtZUYzMTFWM3VHTERFeG5WMGtucDhWYTBS?=
 =?utf-8?B?Zk9VOFlxTm5KaTlYbmVPSERaV2x3VUxoM1hvSnhRWFVVemVMMkhxei9uanUv?=
 =?utf-8?Q?55svXnByvqrfpnw1U1kCRp8REeghj2D+VY5Cw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(376011)(1800799021)(366013)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1hORzdYZEYzQ252VHVjUVJwVzFRcEo2aUg1WXR3V2RPcm11QmpXd0ZselRh?=
 =?utf-8?B?aWtLeTJZdjJrK0diajF3Q3E5UW5HeHl0a3lFRzhSdnY5TXp0TGhmdGsyYmlQ?=
 =?utf-8?B?M09oVVBkUEZENmF0OXFxZ0RCamhseEhBWFFSYVl6SzZlWDRERFZVZ3o2QVRF?=
 =?utf-8?B?WUhWSG1Kcnl6U2pLQlFJbzRZQXR6Ky9tTkxuaTh3TEI1d3R3T3Zid0IySFZJ?=
 =?utf-8?B?V1l1Wm5UaTVvand2ek9mQXJRQ1Z2ckt0NytweDhUQXdyaC9IUTc1dzNNVEM1?=
 =?utf-8?B?aW5yRWZxdEdvWnpva013UU40aURyeEliSTFiWGYvdUxuMFJydGNYTEZFTWMw?=
 =?utf-8?B?a2pvRm5mcTA5VDNMMzRYMmQwS2VsUmxRT0JWV29yK1RSWUZQVkduZnc3elZK?=
 =?utf-8?B?Vk1mMDQ2dnl4UG96ZkFpWGVCa2pYcXBBTVJ2dERDRk1IditleWxQN0Nsb2pR?=
 =?utf-8?B?TVloMzBQeDFzclFLWWc0T3h6NElsQUVGWGlCMzFZU3crTVdRYk5wVGxyMW1y?=
 =?utf-8?B?QUdVYlcwd1R6b0NzS0VzaE9JTHdiYktYb0Z2cEtMek1DdGtVZ3pZZEtvVGJ1?=
 =?utf-8?B?NXYrb01LMUZod21LN1Vva3dLREpOK2prdEtmMVBnSzk0OEdXWkZWbFRZQTB2?=
 =?utf-8?B?cmRYSHk3ZC82UE9Zc1dNM0lNMkZwM2w0UzRNN2JvZi9UdnZYMWhTQURJSm9Y?=
 =?utf-8?B?aUUrRXB6MnRWSzdxTGoybmxNZTEycktWaG9SREdhVHZQd1Z5YjVUMVhsOE9n?=
 =?utf-8?B?czNIeE5mSS9SM2lRN0Q0ckdFNE1OZ0V2Vy9aVmJVODVDU05wQkpOOU9NRGpy?=
 =?utf-8?B?ZmNJMFJzQlBXd3dIRXNmNTNubmZRWkpSM1c1SVFTNTFrMHUyR3RuYUxoamxF?=
 =?utf-8?B?NjU4a2ZpZnFDQlA0bEczZzl5ZitLZWQ4UWtWa0h3V0hTVElBS1BzV0ZjRTVI?=
 =?utf-8?B?TklNbytHdGZ2aytuenFLSWh5WHBxUGM4aHR2dnBidXRLR3VYT2NueC9oTFhh?=
 =?utf-8?B?ZEZkMDBMVXlJaTdoQUUrZkprd1FWUWMrZEhBcjVJc2FFMVZPRFNxUXpWdi8y?=
 =?utf-8?B?MW91T2cxeHFxRUxjUUlnK0ljdHV6M0p3VktlcVdOcE5PZFVJRzc3MGp4Smo3?=
 =?utf-8?B?M0Z3TXVIdkZKUU9pOEtZbnJmRFhPbW9za1FMTEZLcmNVWjVVdWFya2xiQml4?=
 =?utf-8?B?N1VtZjVOTGpUUEhldFdqRi9remZTUmI2WSszN1VmQ0ZCMmlEUTU3T0pvWnRW?=
 =?utf-8?B?RU9Ka1NFZnZHUHg5S3dMczlnQ1VxOUJGbmtydWZGRS9aQ3pQZUx5QVZKbkJ1?=
 =?utf-8?B?UWZvQzQyVlZQdHBTNHY0UDE1TFVwdUVCM0MweGNmYkUyM2ViUkhrUkEwMTVl?=
 =?utf-8?B?RTlYckVyVnhoVDFvelVHbElqeE41Q1oralRUVWM3WFQ2WDJPYTN5WVErS0N5?=
 =?utf-8?B?cTZZazd4SVJQNjIvMlp5elIrM3NNWElheFpYL1RlTUJVRUgzakhUY2ZrS0lU?=
 =?utf-8?B?VVc2NWN0cktFV3BBOU9hQ1c3VDFldE94c1N1N3VTL2srQTJvdG5MVURwK2h5?=
 =?utf-8?B?cHVLU1JyeGg0Z2RqU0hSMC90SGFCNFZ5VTA1OURjU1JrOHI0VXpSQnNJT0ll?=
 =?utf-8?B?NEQrSFltQm9OWC9qMkg0c1pHeHZUcTgwVnYza2hGMHd2VkVBQi9zS2ZOR1BJ?=
 =?utf-8?B?RzlNcG0xNmFyRlRSZXNVZ2tIY3dhcy9VV1I0YW0yUWFLMlBoTHVVMG50dDZw?=
 =?utf-8?B?UG1TVkR3dDNKeWY4TjgzMCtIYllyY0pvSWZsRFJjZnZLdUp5WDEwUGlvVXQr?=
 =?utf-8?B?U0k5K2hUZHUyQnJicituVVF3eHdQREdHUjFCNEJEVm8vNXphVDNadG5kTFVV?=
 =?utf-8?B?VTBQUFBUVGJYK3NEMXpoeHFFSnA4M3lHdFBKb050cHF2cFViMjhtODErL3Zr?=
 =?utf-8?B?UldCSEhTS2JKNlhrNFJYNjZzaTlta21xM1JEV1ZaR084eTd5Ujk1TjhRSnFy?=
 =?utf-8?B?V1h0UzB3NG4wNE9uNFFZL0NNSVBSVW9RamZETjQ4NjZOSnVHZmNMcnBzU0pw?=
 =?utf-8?B?L0RLaTdXcTdaUmhBUm1Cd3NvbDEyaGp3Q2pqTWhBd1owKzF4eVZMRXVwRGwx?=
 =?utf-8?Q?LZvw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd81879-8ea1-44ee-4cbb-08dc8f870369
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 11:08:41.9812 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /m62r55dsWqJ/TIOb9G005OsUg6VqIo3yvKLVRN63zdQwdVjV97WEo9fRFBXksg+q0MqzzqBw5Jv5Y0jor1S5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7315
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KLS0tLS0tLS0tLS0tLS0tLS0NCkJlc3QgUmVnYXJkcywNClRob21hcw0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4N
ClNlbnQ6IFR1ZXNkYXksIEp1bmUgMTgsIDIwMjQgNjowOSBQTQ0KVG86IENoYWksIFRob21hcyA8
WWlQZW5nLkNoYWlAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzog
WmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IFpob3UxLCBUYW8gPFRhby5a
aG91MUBhbWQuY29tPjsgTGksIENhbmRpY2UgPENhbmRpY2UuTGlAYW1kLmNvbT47IFdhbmcsIFlh
bmcoS2V2aW4pIDxLZXZpbllhbmcuV2FuZ0BhbWQuY29tPjsgWWFuZywgU3RhbmxleSA8U3Rhbmxl
eS5ZYW5nQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIDQvNV0gZHJtL2FtZGdwdTogYWRk
IGNvbXBsZXRpb24gdG8gd2FpdCBmb3IgcmFzIHJlc2V0IHRvIGNvbXBsZXRlDQoNCg0KDQpPbiA2
LzE4LzIwMjQgMTI6MDMgUE0sIFlpUGVuZyBDaGFpIHdyb3RlOg0KPiBBZGQgY29tcGxldGlvbiB0
byB3YWl0IGZvciByYXMgcmVzZXQgdG8gY29tcGxldGUuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFlp
UGVuZyBDaGFpIDxZaVBlbmcuQ2hhaUBhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYyB8IDExICsrKysrKysrKysrDQo+IGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuaCB8ICAxICsNCj4gIDIgZmlsZXMgY2hhbmdlZCwg
MTIgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3Jhcy5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3Jhcy5jDQo+IGluZGV4IDg5ODg4OTYwMDc3MS4uN2Y4ZTZjYTA3OTU3IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMNCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jDQo+IEBAIC0xMjQsNiArMTI0LDggQEAg
Y29uc3QgY2hhciAqZ2V0X3Jhc19ibG9ja19zdHIoc3RydWN0IHJhc19jb21tb25faWYNCj4gKnJh
c19ibG9jaykNCj4NCj4gICNkZWZpbmUgQU1ER1BVX1JBU19SRVRJUkVfUEFHRV9JTlRFUlZBTCAx
MDAgIC8vbXMNCj4NCj4gKyNkZWZpbmUgTUFYX1JBU19SRUNPVkVSWV9DT01QTEVUSU9OX1RJTUUg
IDEyMDAwMCAvL21zDQo+ICsNCj4gIGVudW0gYW1kZ3B1X3Jhc19yZXRpcmVfcGFnZV9yZXNlcnZh
dGlvbiB7DQo+ICAgICAgIEFNREdQVV9SQVNfUkVUSVJFX1BBR0VfUkVTRVJWRUQsDQo+ICAgICAg
IEFNREdQVV9SQVNfUkVUSVJFX1BBR0VfUEVORElORywNCj4gQEAgLTI1MTgsNiArMjUyMCw4IEBA
IHN0YXRpYyB2b2lkIGFtZGdwdV9yYXNfZG9fcmVjb3Zlcnkoc3RydWN0IHdvcmtfc3RydWN0ICp3
b3JrKQ0KPiAgICAgICAgICAgICAgIGF0b21pY19zZXQoJmhpdmUtPnJhc19yZWNvdmVyeSwgMCk7
DQo+ICAgICAgICAgICAgICAgYW1kZ3B1X3B1dF94Z21pX2hpdmUoaGl2ZSk7DQo+ICAgICAgIH0N
Cj4gKw0KPiArICAgICBjb21wbGV0ZV9hbGwoJnJhcy0+cmFzX3JlY292ZXJ5X2NvbXBsZXRpb24p
Ow0KPiAgfQ0KPg0KPiAgLyogYWxsb2MvcmVhbGxvYyBicHMgYXJyYXkgKi8NCj4gQEAgLTI5MTEs
MTAgKzI5MTUsMTYgQEAgc3RhdGljIGludA0KPiBhbWRncHVfcmFzX3BvaXNvbl9jb25zdW1wdGlv
bl9oYW5kbGVyKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPg0KPiAgICAgICAgICAgICAg
IGZsdXNoX2RlbGF5ZWRfd29yaygmY29uLT5wYWdlX3JldGlyZW1lbnRfZHdvcmspOw0KPg0KPiAr
ICAgICAgICAgICAgIHJlaW5pdF9jb21wbGV0aW9uKCZjb24tPnJhc19yZWNvdmVyeV9jb21wbGV0
aW9uKTsNCj4gKw0KPiAgICAgICAgICAgICAgIGNvbi0+Z3B1X3Jlc2V0X2ZsYWdzIHw9IHJlc2V0
Ow0KPiAgICAgICAgICAgICAgIGFtZGdwdV9yYXNfcmVzZXRfZ3B1KGFkZXYpOw0KPg0KPiAgICAg
ICAgICAgICAgICpncHVfcmVzZXQgPSByZXNldDsNCj4gKyAgICAgICAgICAgICBpZiAoIXdhaXRf
Zm9yX2NvbXBsZXRpb25fdGltZW91dCgmY29uLT5yYXNfcmVjb3ZlcnlfY29tcGxldGlvbiwNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXNlY3NfdG9famlmZmllcyhNQVhfUkFTX1JF
Q09WRVJZX0NPTVBMRVRJT05fVElNRSkpKQ0KPiArICAgICAgICAgICAgICAgICAgICAgZGV2X2Vy
cihhZGV2LT5kZXYsICJXYWl0aW5nIGZvciBHUFUgdG8gY29tcGxldGUgcmFzIHJlc2V0IHRpbWVv
dXQhIHJlc2V0OjB4JXhcbiIsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlc2V0
KTsNCg0KPiBJZiBhIG1vZGUtMSByZXNldCBnZXRzIHRvIGV4ZWN1dGUgZmlyc3QgZHVlIHRvIGpv
YiB0aW1lb3V0L2h3cyBkZXRlY3QgY2FzZXMgaW4gcG9pc29uIHRpbWVvdXQsIHRoZW4gdGhlIHJh
cyBoYW5kbGVyIHdpbGwgbmV2ZXIgZ2V0IGV4ZWN1dGVkLg0KPiBXaHkgdGhpcyB3YWl0IGlzIHJl
cXVpcmVkPw0KDQpbVGhvbWFzXSAgIltQQVRDSCA1LzVdIGRybS9hbWRncHU6IGFkZCBncHUgcmVz
ZXQgY2hlY2sgYW5kIGV4Y2VwdGlvbiBoYW5kbGluZyIgYWRkIHRoZSBjaGVjayBiZWZvcmUgcmFz
IGdwdSByZXNldC4NCg0KDQpUaGFua3MsDQpMaWpvDQoNCj4gICAgICAgfQ0KPg0KPiAgICAgICBy
ZXR1cm4gMDsNCj4gQEAgLTMwNDEsNiArMzA1MSw3IEBAIGludCBhbWRncHVfcmFzX3JlY292ZXJ5
X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ICAgICAgICAgICAgICAgfQ0KPiAg
ICAgICB9DQo+DQo+ICsgICAgIGluaXRfY29tcGxldGlvbigmY29uLT5yYXNfcmVjb3ZlcnlfY29t
cGxldGlvbik7DQo+ICAgICAgIG11dGV4X2luaXQoJmNvbi0+cGFnZV9yc3ZfbG9jayk7DQo+ICAg
ICAgIElOSVRfS0ZJRk8oY29uLT5wb2lzb25fZmlmbyk7DQo+ICAgICAgIG11dGV4X2luaXQoJmNv
bi0+cGFnZV9yZXRpcmVtZW50X2xvY2spOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5oDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3Jhcy5oDQo+IGluZGV4IDkxZGFmNDhiZTAzYS4uYjQ3ZjAzZWRhYzg3IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmgNCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5oDQo+IEBAIC01MzcsNiArNTM3
LDcgQEAgc3RydWN0IGFtZGdwdV9yYXMgew0KPiAgICAgICBERUNMQVJFX0tGSUZPKHBvaXNvbl9m
aWZvLCBzdHJ1Y3QgcmFzX3BvaXNvbl9tc2csIDEyOCk7DQo+ICAgICAgIHN0cnVjdCByYXNfZWNj
X2xvZ19pbmZvICB1bWNfZWNjX2xvZzsNCj4gICAgICAgc3RydWN0IGRlbGF5ZWRfd29yayBwYWdl
X3JldGlyZW1lbnRfZHdvcms7DQo+ICsgICAgIHN0cnVjdCBjb21wbGV0aW9uIHJhc19yZWNvdmVy
eV9jb21wbGV0aW9uOw0KPg0KPiAgICAgICAvKiBGYXRhbCBlcnJvciBkZXRlY3RlZCBmbGFnICov
DQo+ICAgICAgIGF0b21pY190IGZlZDsNCg==
