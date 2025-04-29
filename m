Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91188C3ABA9
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 09:02:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9051D10E3E7;
	Tue, 29 Apr 2025 09:02:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3wMrMnIl";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D29E10E3E7
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 09:02:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DoYMspJZy53A0rYUuMzJb/Ql/twmqUF9aIg9J2HouZc4FBfzde81tGb9cjLSdJfQtdFXJRes/ljmUoROeTBl7F7LdhAmv4z46aLAbp5xkyC2aVBSY5HDkquOnUnpHp3Vk3nzmNx56aTNcG04i/5ybhj/UiP9bPWtJo+o/oR8nkrU3VoVoqWiSsSE7Z9ptrlB21+BL333zeeqKXli8EmpUA9gg4bbhD0481Tn66E3eQyvD07jXVnkdquCJ4wtUAfWPAc0yfEg+j5B1Ur3RJTaeBP5RIchGLx30S0ettQSqfu5whkYwjRo/pjLdw0xW1BjvJSEjxJdHJzZiovvUnus7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nIO6gxmL2P38ARkP2Hge/StruOAgmEfmPodlFZWHxs=;
 b=c8ypwZ/K1rmZ0W8Vqw49xZCA79Uuq81zA54o4/A2PsTZ6a8Al3pexi8LaNWURlZkv9QWCyCeJgxJxtQD7x08xGVpz7lHOeNeAmeqRQkZyCY86c5FYLaVNMHmemuRi92uCJbod5kHNpWgK2FlzD7yqbNhcAO6j4zJnISCZbse/ltQavF8OCSoqzuvlzuKuUnFtoNt5rucWT/7HcTwZ6Tq/I1sw5R0QHoEWbwdkGXPneTbgDvJssUA3p+UHqbBQt6HZAnvSZHdZPHd0M2UJf8w2ITdwkjvtx9lDfOIdoQ/mkGYxSzk0v8FjX09n5M/qIyhKVA+7XwJT6Q4YaXhqzVJtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nIO6gxmL2P38ARkP2Hge/StruOAgmEfmPodlFZWHxs=;
 b=3wMrMnIlrYU+8wdVSE/Inv/Cy9JBVU9JJY7y7d4uiTZ7ID24zXq4rglUTX33bi0ImKQn+n6QT5Gm44vDbzURJRNPKBus0+/ZqRAi4OsUcDHuLVeYciJsaKVFfoXOPgIj0MGdKLzxwgP17ypZ8WG5JF1JzEe4eVgbai9z2tJzIcM=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 IA1PR12MB6092.namprd12.prod.outlook.com (2603:10b6:208:3ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 09:02:14 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 09:02:14 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Yadav, Arvind"
 <Arvind.Yadav@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: implicitly sync the dependent read fences
Thread-Topic: [PATCH 1/3] drm/amdgpu: implicitly sync the dependent read fences
Thread-Index: AQHbtbC+ccKGxg3NBU6MKAwb+Y5nY7Oz+dSAgAAFcQCAAtoiUIACTvgAgAEzRFA=
Date: Tue, 29 Apr 2025 09:02:14 +0000
Message-ID: <DS7PR12MB60059FA9861ECA2B7355E189FB802@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250425070730.4033803-1-Prike.Liang@amd.com>
 <b7011f0d-cdda-9318-ddd7-6c36f6581ad9@amd.com>
 <DS7PR12MB60058C12C12F37C34ADE31E5FB842@DS7PR12MB6005.namprd12.prod.outlook.com>
 <DS7PR12MB6005A31931084FC36F628C8BFB862@DS7PR12MB6005.namprd12.prod.outlook.com>
 <8fb7f933-45ef-4824-8477-1bb6a80d9a72@amd.com>
In-Reply-To: <8fb7f933-45ef-4824-8477-1bb6a80d9a72@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=0f4ad0b7-c7b4-435f-9cf2-53761b735c7b;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-29T08:48:57Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|IA1PR12MB6092:EE_
x-ms-office365-filtering-correlation-id: 8ca0969f-22e6-449d-96fb-08dd86fc88fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?TWpaaFlnNEpycVFhVWJJbWZvQjRXNlFhRzJ0WDhtOUpmTmM1TzNXWi9CSTlT?=
 =?utf-8?B?b1I3YUZTMFZSTVFXVWxhV2R6WkxLTUQrc0NxdlIxeU5YdnVNaFJRL0ZxQkkv?=
 =?utf-8?B?SzNvMnozb0paTkdKNVpoWWc0TkF3dlBjeEluVXlDNCs1dC9kY0Y4a3lCM1hn?=
 =?utf-8?B?US9uR0ZiODFnaVZTSjFiUXpLdTNucWY1OVByckdESUFDeEFWUEZJNGZEaTJF?=
 =?utf-8?B?MDZXTkFqR3ZnNTVXcUIwZjhERFN1bVJYQis3UzYwUW1ycUxzY243V3QrdTJ0?=
 =?utf-8?B?NlgwN2FJVG11SFhrVGlSalpCK1J4a0MvTFQwZnJQb3RFQXBpTHEwZCtjM2tH?=
 =?utf-8?B?MHhFRkV2YzBwOXNVQjZVWGYxaDY4SS9uTGttUEpYRVE5WW9xZGFXcXVDdmJr?=
 =?utf-8?B?ckpOb1l4TGw5ejNBcHYxT0tZMStkOFNiRS95SzEwVU5Db0JxbTRvM0ZHelJM?=
 =?utf-8?B?b2tONjhxZFNNczc0c2lGODlXSlFFNHRWdVdGOEhWK1Z6OGl5WWpzK2VvSDh1?=
 =?utf-8?B?VFBDSCtGNWxSMGhqcU5hZm1PeG96aHJMck5xcVhXWWtHdjlLMFNNUStycVNO?=
 =?utf-8?B?V1Q5Mm9lTjVEN01uY0JiNmpwQVZoUFNSZXRabUw5STE4aThmRytiUzJ3ck5J?=
 =?utf-8?B?NVN0Zmh6cjZ5UUZDYkpLOWZiU0ZudjBmWHhPVVgwZk43THdlZE9QUnhTS0RV?=
 =?utf-8?B?SUJQYzdIRnRRL0M0Q254ODBjTXJ0eUY4MElCNGhtcEdDaXdyUEJMenZ2Z0pI?=
 =?utf-8?B?eUpTKzl1ME80dXloRmRGQjN4RXVGSDVPTG9GNm4weTZGNkdJYytBSjduTitp?=
 =?utf-8?B?WXNvN2FDK1JMYmU1UmR2KzB5Ujd4KzlScFNNUHl4YkxmNnZOTU1FMWwrSy9W?=
 =?utf-8?B?cnI2dHVVYkp2WHc5S25NTDdhdWpBUWVwc3pKT1oyQmNBbUJBdmxvazh0QVNr?=
 =?utf-8?B?NDhocmxwQ25hanRlaEFncUgrNHdUQ1NXa0wvdWxOU3psSUV3em5NYmtkMUFD?=
 =?utf-8?B?SEx0VS8zZ1AweWRmRWdtb2dhc3p2YkdJdi93dFNsdlZLNmc2eXFNaXIzamRl?=
 =?utf-8?B?T0o0czFzbkp1ZTBtODlXYlRoWUk4YThCRWI0TjQ0ZnRvK1B1QW5LN25Udk5X?=
 =?utf-8?B?N01Gb2hTU1puTjJ5YzBuVzVCTitQUTBzTEFzRWZDVW1KKzRwY0NvKzIxVGJa?=
 =?utf-8?B?TjVkUHArUXpqbC9SNmF4dVF3WmJHUHJRSk9HUUdyL25vY2VaOTZkd2dpejdn?=
 =?utf-8?B?NWhLTGNxcmw3Zlowem85OWp0YlNxeWhCME5yTjZvbDRzOU03aERlVWtrdEtw?=
 =?utf-8?B?ekNwVzQ5T2tSM2NJeWF6VzRZSTZXcGlJSk9RN0hXRDZ4V1pQdHpaMXc5RTlO?=
 =?utf-8?B?V0FuS3picjdTSFpBSTZGRm1BRjd4UEliOUxwa0JqNzdvYVA1NS9lQ3QyL3lS?=
 =?utf-8?B?S050Q0w3Mmcrak1FbEdJTmpXQ1FhRHU4eW9ndXJ6MElQUEdSUE5jcFVlMXJQ?=
 =?utf-8?B?Q3ltRDE0a0UzUDhLQ2VPN1h3Z3BicUE0a2tnMHk3ckZDU1ZKUEZRN3VMM1gy?=
 =?utf-8?B?Mm5WcXVYc2pWQjVSN05UNE1IVnRuZVZ0Yjl1ODdJb2ZsYXo0eDZ4azNWS1lW?=
 =?utf-8?B?WVBRY0VLYkVacEkvL0g1NzZId2tCam01MmFINGN0dytzdVpCWFhCMWtMRWlo?=
 =?utf-8?B?cDR4UXp0eTYxLzFHdWVUZC82S3lKWkEzenJ2SThSanlvRWJ0Rm14T2ZsM2pX?=
 =?utf-8?B?TWxZamtYRUc4OEhxUnFobjlRQ0NjMG5jY2Rtc3VENk02cFh1L3BBdUlBbXpS?=
 =?utf-8?B?SVp2cExQRXcyR0xlc1AxSDl4RU1kdTdORmRNdGJYT2N0YVUvRklvVUtIZmN1?=
 =?utf-8?B?bnhjMmEvK0lVRHBZeDN3U0dsV1pRajlkTWMxQkY3RGlacTM1TDdTVWpMTlcv?=
 =?utf-8?B?OGFGREJIYWFpbitTUG9HUW5Ec01mZ1RvRk1TWXlVUG5ERWUxN05mUmF0Mis5?=
 =?utf-8?B?eS9GL3NYUkNBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHhUREJEbFVwUUVNK3NPci9nczA5T1dYVFE1dFlWbExna1Zva1BrL083NnJk?=
 =?utf-8?B?ZGVIVXJlcnFJY2Q3VVltdUwxK3BPQS9za1dmRks1YzVzRVU0ZlFHKzU3VHRm?=
 =?utf-8?B?aGhKb1VmdkVRM2ZtZWNJaEttYlErN2U4MCtWZjJ5SDlUNEVZaFluSFFHMUNX?=
 =?utf-8?B?c3FyZFdTWWJzc2lnbUVPZ0dkT1JFK2Y5NkNidHRuQzNnQWdPVWVwaHlQdkRu?=
 =?utf-8?B?M2NSNG5hVjd0Q2dHNDhCQVJJay9NU3BsN21wUTlkLy9KVXV6TU1WOFJjMGlM?=
 =?utf-8?B?YzJXK2svL1dVYjE3UEpiZWdtdXRjWnJkNS9EMFlicDdGdDJzUlc1UE01YUMx?=
 =?utf-8?B?U2tRK013bzQyZTVZMTZacFEvWmhKcUp5RnNaMWNPSkpSMjFjVHhna3Z1QU16?=
 =?utf-8?B?Wml0RksvUklFNi9aQWk5SkJWVVFiVFJTOEdlM0JsZVllNkM2bGk0QTYyNEJr?=
 =?utf-8?B?VkpJL2NJVnNkRWJtN2ZSdFROVjdCek9uc1QwdzhSRk1KK3lteStzZWxVMFJW?=
 =?utf-8?B?dDhlYmxkL0FKM1F2Um45UlFSQ09DeFJQb3dicDAzZzBsYngwSXRvWUdxWlhk?=
 =?utf-8?B?MDNiejFVYUhVZ2tNWlh6N1BnOWpMS2pVMFJRU21ZMEFyUXJXdU4ramFkcWNk?=
 =?utf-8?B?RTNjeStPa0FUaDY5Z000cmEvZ1JDNmM5K24ySGtXb3VwZGNTUHVmMUVEcEZn?=
 =?utf-8?B?NkcrcVI4d05oaC9RTVR0aW5kR3ZYVjhvYjFRbmsrRi83TE00YW9NR05TeWVQ?=
 =?utf-8?B?S0xLeHBtNnpHTHpnWkU3WjNDYlY4aFZRd2JZanVpajdqUDhhMnc2VXRzZUpI?=
 =?utf-8?B?S2QxMGh3Mk9xc3VEWjkyaEhQM0xmRCtucDc5ZXNqNDhGbG0yTzZoZXJCeUYy?=
 =?utf-8?B?cW8yaVk4RVJaaFNaRFJ3Vjl1SWpvMjhEakRaK2pSMjNXUVl0S0dVYkRrMXA1?=
 =?utf-8?B?QUlQSFlOYmw3aHdzTVhWQVEza1l4STBvbzE5aFZ6Tlh3ZDE0dWxOY2lmL3dr?=
 =?utf-8?B?R3czRlJCZldsS096THAzZXR2Sy94YUo5OVN6U3B1d25XcUV0VHd6WWpBNFc5?=
 =?utf-8?B?S252aGVIUWNma014emM0OVdtV0pvWmJ4VXZXZXhHbGtyK2dydGFBbER2Mk1M?=
 =?utf-8?B?YlkwNk16dE5BZUFKVm94T1NRUURNRnhodzI0em1FOGJxRjcwQlpqd0tDNEIw?=
 =?utf-8?B?LzVUUkxyenhCVkNLaWNNUjlzaFVReDBKTGZJN0JacWhvWUFQS08rek1zVGl2?=
 =?utf-8?B?bU4xVTRTd2kvMVEzTTlKVVhqclJpdHc3UEN6M3NGWkVKTDROQlQ1YnNoNWhh?=
 =?utf-8?B?eWxqSkRTa0FpZXZnMHdZWDJpbEpXZG9FTzcwM09ZeEpzbHRZcXJvd0RLM1c3?=
 =?utf-8?B?S2dkcjVObFZma3dlT2lFeGlEQlNQdFd2ak5NYzZrc0UwUVFGZlVrd2VDWlpi?=
 =?utf-8?B?TVlMc1YxVlR4NnNNckl6cHUrdFhWN3dnQTRsdGdYVUpySU9xeEQvaEk0a2Q2?=
 =?utf-8?B?eXRnNEI2dkhHM1RDYVI0cXRkZTNsOVkvRDlTYVZHZ1dRaitLaUdoQWdjWXA2?=
 =?utf-8?B?QVI0eS9oQU9EVGs1RTlxOGFDQ3pRaHJmay80UUVDa05ra0RxVFlaYmQ5UCtW?=
 =?utf-8?B?L2pHY2ZJVm54OHFNRUIxRWhnUTJ2aStzMk9ucDJYMUZGc1hscHZrenFpQ09W?=
 =?utf-8?B?enk3ZnpMeTBlS0owamxwY2FmZlJNTXlVZUVNK3pRT3Y3RkVXZWswcWoxdVRu?=
 =?utf-8?B?aGdyOGt3OUs5UWZHcDBwUkoyYTA1OUV5R3ZxNWNZNDRoTGswL3ZVVHNRS3NO?=
 =?utf-8?B?SzB3bDVKVktibEVqTjNxWjNXQUtqcFRoQVRzKzFVNDJhOFhUT0syUENCcnN3?=
 =?utf-8?B?OFFNbE53NUxsc1cxVlZkek5PYnoySXg3dmo4dDQ4VENwVGdjLzJZQXZmaUQz?=
 =?utf-8?B?c2Z3L21Cck5wbkdzOGlldHBHT0tDcEdUY3dZNjAwVFZnaEdVZ0R4UFpzV3c3?=
 =?utf-8?B?L3puZjE0Zm1JTjQyWmFaS1lHdGZIcVFCcS9vQS9IV0lieUo4dE5XQXJ6Zjdx?=
 =?utf-8?B?eDF0NUovaStNbnZjUXlCWW1aNHlPclpWajhLY0V1blFsSXFLaWt4Rm4xRHI1?=
 =?utf-8?Q?dVM8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca0969f-22e6-449d-96fb-08dd86fc88fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 09:02:14.4013 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SIphLdRZ7evRxQ7LMMcSClu+OrTQj5AK9RTx9dyp75Vuc/Ns4RgIDi3ZsrlUeRbe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6092
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

W1B1YmxpY10NCg0KPiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0Bh
bWQuY29tPg0KPiBTZW50OiBNb25kYXksIEFwcmlsIDI4LCAyMDI1IDEwOjI5IFBNDQo+IFRvOiBM
aWFuZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+OyBZYWRhdiwgQXJ2aW5kDQo+IDxBcnZp
bmQuWWFkYXZAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBE
ZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggMS8zXSBkcm0vYW1kZ3B1OiBpbXBsaWNpdGx5IHN5bmMgdGhlIGRlcGVuZGVu
dCByZWFkIGZlbmNlcw0KPg0KPiBPbiA0LzI3LzI1IDA1OjIwLCBMaWFuZywgUHJpa2Ugd3JvdGU6
DQo+ID4gW1B1YmxpY10NCj4gPg0KPiA+PiBGcm9tOiBMaWFuZywgUHJpa2UNCj4gPj4gU2VudDog
RnJpZGF5LCBBcHJpbCAyNSwgMjAyNSAzOjQ0IFBNDQo+ID4+IFRvOiBZYWRhdiwgQXJ2aW5kIDxB
cnZpbmQuWWFkYXZAYW1kLmNvbT47DQo+ID4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQo+ID4+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+
OyBLb2VuaWcsIENocmlzdGlhbg0KPiA+PiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiA+
PiBTdWJqZWN0OiBSRTogW1BBVENIIDEvM10gZHJtL2FtZGdwdTogaW1wbGljaXRseSBzeW5jIHRo
ZSBkZXBlbmRlbnQNCj4gPj4gcmVhZCBmZW5jZXMNCj4gPj4NCj4gPj4+IEZyb206IFlhZGF2LCBB
cnZpbmQgPEFydmluZC5ZYWRhdkBhbWQuY29tPg0KPiA+Pj4gU2VudDogRnJpZGF5LCBBcHJpbCAy
NSwgMjAyNSAzOjIxIFBNDQo+ID4+PiBUbzogTGlhbmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQu
Y29tPjsNCj4gPj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+ID4+PiBDYzogRGV1
Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLA0KPiA+
Pj4gQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+ID4+PiBTdWJqZWN0OiBS
ZTogW1BBVENIIDEvM10gZHJtL2FtZGdwdTogaW1wbGljaXRseSBzeW5jIHRoZSBkZXBlbmRlbnQN
Cj4gPj4+IHJlYWQgZmVuY2VzDQo+ID4+Pg0KPiA+Pj4gVGhpcyBpcyBwcm9ibGVtIGZvciBUTEIg
Zmx1c2guIFdlIHNob3VsZCBub3QgZG8gdGhpcyBjaGFuZ2VzLiBIZXJlDQo+ID4+PiB3ZSBhcmUg
dXRpbGl6aW5nIERNQV9SRVNWX1VTQUdFX0JPT0tLRUVQIGR1ZSB0byB0aGUgVExCIGZsdXNoIGZl
bmNlDQo+ID4+PiBhc3NvY2lhdGVkIHdpdGggdGhlIHBhZ2UgdGFibGUgKFBUKS4gV2UgYXJlIGVu
c3VyaW5nIHRoYXQgbm8gcGFnZQ0KPiA+Pj4gZGlyZWN0b3J5IChQRCkgb3IgcGFnZSB0YWJsZSAo
UFQpIHNob3VsZCBiZSBmcmVlIGJlZm9yZSBmbHVzaCBhbmQNCj4gPj4+IHR0bSBibyByZWxlYXNl
IGFuZCBkZWxldGUgYm90aCBhcmUgYWxzbyB3YWl0aW5nIGZvciBCT09LS0VFUCBmZW5jZS4NCj4g
Pj4+IFBsZWFzZSBkcm9wDQo+ID4+IHRoaXMgY2hhbmdlcyBmb3IgZXZpY3Rpb24gZmVuY2UuDQo+
ID4+IFRoYW5rcyBmb3Igc2hhcmluZyB0aGUgYmFja2dyb3VuZC4gU28sIHdlIG1heSBuZWVkIHRv
IHRlc3QgdGhlIGZlbmNlDQo+ID4+IHdoZXRoZXIgaXMgYW4gZXZpY3Rpb24gZmVuY2UgaW4gYW1k
Z3B1X3N5bmNfdGVzdF9mZW5jZSAoKSBiZWZvcmUgYWRkZWQgaXQgdG8NCj4gdGhlIFZNIHN5bmMu
DQo+ID4gSXQgbG9va3MgdGhlIFRMQiBmbHVzaCBmZW5jZSBvbmx5IGFkZGVkIHRvIHRoZSBWTSBC
TyByZXNlcnZhdGlvbiBhbmQgcmVxdWlyZXMgYQ0KPiBzeW5jIGF0IGNvbXB1dGUgVk0uDQo+DQo+
IFRoZSBUTEIgZmx1c2ggZmVuY2Ugc2hvdWxkIGFsd2F5cyBiZSBleHBsaWNpdGx5IHN5bmNlZCB0
byBieSB0aGUgS0ZELg0KPg0KPiBXaGVyZSBkbyB5b3Ugc2VlIHRoYXQgaXQgaXMgaW1wbGljaXRs
eSBzeW5jZWQgdXNpbmcgdGhlIGFtZGdwdV9zeW5jIG9iamVjdGVkPw0KDQogPj4+Pj4vKiBQcmVw
YXJlIGEgVExCIGZsdXNoIGZlbmNlIHRvIGJlIGF0dGFjaGVkIHRvIFBUcyAqLw0KLT4+Pj4+Pj5p
ZiAoIXBhcmFtcy0+dW5sb2NrZWQgJiYgdm0tPmlzX2NvbXB1dGVfY29udGV4dCkgew0KLT4+Pj4+
Pj4tPj4+Pj4+PmFtZGdwdV92bV90bGJfZmVuY2VfY3JlYXRlKHBhcmFtcy0+YWRldiwgdm0sIGZl
bmNlKTsNCg0KLT4+Pj4+Pj4tPj4+Pj4+Pi8qIE1ha2VzIHN1cmUgbm8gUEQvUFQgaXMgZnJlZWQg
YmVmb3JlIHRoZSBmbHVzaCAqLw0KLT4+Pj4+Pj4tPj4+Pj4+PmRtYV9yZXN2X2FkZF9mZW5jZSh2
bS0+cm9vdC5iby0+dGJvLmJhc2UucmVzdiwgKmZlbmNlLA0KLT4+Pj4+Pj4tPj4+Pj4+Pi0+Pj4+
Pj4+LT4+Pj4+Pj4gICBETUFfUkVTVl9VU0FHRV9CT09LS0VFUCk7DQotPj4+Pj4+Pn0NClllcywg
dGhlIFRMQiBmbHVzaCBmZW5jZSBpcyBleHBsaWNpdGx5IHN5bmMgYW5kIHRoZSBmbHVzaCBzaG91
bGQgYmUgcGVyZm9ybWVkIGFmdGVyIHRoZSBkZXBlbmRlbnQgUEQvUFQgZmVuY2Ugc2lnbmFsZWQu
DQpUbyB0aGUgQXJ2aW5kJ3MgY29uY2VybiBvbiB0aGUgVExCIGZsdXNoIGZlbmNlIHNob3VsZCBi
ZSBoYW5kbGVkIHByb3Blcmx5IGJ5IGV4cGxpY2l0bHkgc3luY2luZyB0aGUgVExCIGZlbmNlLCBz
byBpdCdzDQpvayB0byBwcm9tb3RlIHRoZSBpbXBsaWNpdCBzeW5jIHRvIHRoZSBSRUFEIGZlbmNl
IGZyb20gdGhlIEJPT0tFRVA/DQoNClRoYW5rcywNClByaWtlDQo+IFJlZ2FyZHMsDQo+IENocmlz
dGlhbi4NCj4NCj4gPiBBcyB0byB0aGUgVk0gcmVzZXJ2YXRpb24gc3luYyB3aGV0aGVyIGNhbiBy
ZXR1cm4gYW5kIHN5bmMgdG8gdGhlDQo+ID4gRE1BX1JFU1ZfVVNBR0VfUkVBRCwgYW5kIEkgd2ls
bCBmdXJ0aGVyIGNoZWNrIGl0IHNlcGFyYXRlbHkgd2l0aCB0aGUNCj4gPiBldmljdGlvbiBmZW5j
ZSByZWxlYXNlLiBBcyB0byB0aGUgZXZpY3Rpb24gZmVuY2Ugc3luYyBwcm9ibGVtIGlzc3VlLCBJ
IHdvdWxkIGxpa2UNCj4gdG8gcHV0IGV4Y2x1ZGUgdGhlIGV2aWN0aW9uIGZlbmNlIHN5bmMgYXQg
YW1kZ3B1X3N5bmNfdGVzdF9mZW5jZSgpLg0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IFByaWtlDQo+
ID4+IFRoYW5rcywNCj4gPj4gUHJpa2UNCj4gPj4+IFJlZ2FyZHMsDQo+ID4+PiB+YXJ2aW5kDQo+
ID4+Pg0KPiA+Pj4gT24gNC8yNS8yMDI1IDEyOjM3IFBNLCBQcmlrZSBMaWFuZyB3cm90ZToNCj4g
Pj4+PiBUaGUgZHJpdmVyIGRvZXNuJ3Qgd2FudCB0byBzeW5jIG9uIHRoZSBETUFfUkVTVl9VU0FH
RV9CT09LS0VFUA0KPiA+PiB1c2FnZQ0KPiA+Pj4+IGZlbmNlcywgc28gaGVyZSBvbmx5IHJldHVy
biBhbmQgc3luYyB0aGUgZGVwZW5kZW50IHJlYWQgZmVuY2VzLg0KPiA+Pj4+DQo+ID4+Pj4gU2ln
bmVkLW9mZi1ieTogUHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+ID4+Pj4gLS0t
DQo+ID4+Pj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc3luYy5jIHwgNSAr
Ky0tLQ0KPiA+Pj4+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkNCj4gPj4+Pg0KPiA+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfc3luYy5jDQo+ID4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfc3luYy5jDQo+ID4+Pj4gaW5kZXggNTU3NmVkMGI1MDhmLi40ZTFkMzBlY2I2Y2MgMTAw
NjQ0DQo+ID4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3N5bmMu
Yw0KPiA+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zeW5jLmMN
Cj4gPj4+PiBAQCAtMjQ5LDkgKzI0OSw4IEBAIGludCBhbWRncHVfc3luY19yZXN2KHN0cnVjdCBh
bWRncHVfZGV2aWNlDQo+ID4+Pj4gKmFkZXYsIHN0cnVjdCBhbWRncHVfc3luYyAqc3luYywNCj4g
Pj4+Pg0KPiA+Pj4+ICAgICAgICAgICBpZiAocmVzdiA9PSBOVUxMKQ0KPiA+Pj4+ICAgICAgICAg
ICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+Pj4+IC0NCj4gPj4+PiAtIC8qIFRPRE86IFVz
ZSBETUFfUkVTVl9VU0FHRV9SRUFEIGhlcmUgKi8NCj4gPj4+PiAtIGRtYV9yZXN2X2Zvcl9lYWNo
X2ZlbmNlKCZjdXJzb3IsIHJlc3YsDQo+ID4+PiBETUFfUkVTVl9VU0FHRV9CT09LS0VFUCwgZikg
ew0KPiA+Pj4+ICsgLypPbmx5IHJldHVybiBhbmQgc3luYyB0aGUgZmVuY2VzIG9mIHVzYWdlIDw9
DQo+ID4+PiBETUFfUkVTVl9VU0FHRV9SRUFELiovDQo+ID4+Pj4gKyBkbWFfcmVzdl9mb3JfZWFj
aF9mZW5jZSgmY3Vyc29yLCByZXN2LCBETUFfUkVTVl9VU0FHRV9SRUFELCBmKQ0KPiB7DQo+ID4+
Pj4gICAgICAgICAgICAgICAgICAgZG1hX2ZlbmNlX2NoYWluX2Zvcl9lYWNoKGYsIGYpIHsNCj4g
Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkbWFfZmVuY2UgKnRtcCA9DQo+
ID4+Pj4gZG1hX2ZlbmNlX2NoYWluX2NvbnRhaW5lZChmKTsNCj4gPj4+Pg0KDQo=
