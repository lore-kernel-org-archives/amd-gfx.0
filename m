Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B9FC83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 13:43:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9588310EA5E;
	Fri, 11 Jul 2025 13:43:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zKbw2r3y";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5560D10EA5E
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 13:43:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLgIePUhWuABEEI16rGplNUQ9pTHETUl836c1UwO6Z8kJAaT5BYgSgxB0eiyVloKV906g/XTs9Z4FRmqBOFsQ4oWB5+KBn4Y3HAtCd/iR8XKQTzMOxAEOYsossJABLDS71h8PAh4BRaeuDjJunH9sr5JUSt353GuWOStlqEHnZu+HO7J54qk3thv3wr0YEfh4r+tu4k9poKsosQrflm2+3uSknJrLtRriaUp/lLNtTIdyqBw3zMwkVjVWGhbRSwX3v5mPOKrNawVMZWM/1p9Hnvb01+mbRBex7qh+ceOG/zQhes9UGr2jxFI/G7//UlazQYeFL/3xPruzLcGt+pCWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrNZ3iJV60uk6EK6QN7twsKLPNFXh38MAvnEgKME0JU=;
 b=F6VzAQ5xXIvkT3KoY2zO+UdsDNBtIYq3vy8opa5RyLKCZssU/eM9MIKpXtv9a0svZI+C537iqHFYXl9Q8Py6gmn1nOMqVPKmo9VFYPfKkDhrZUL8JWNr+s+ZCUAwN24xe1MbtcZGlO7meBhSHaFEk9ucgSaBFbUdQCcjBf9yKFYApkAlU4cH2HLE5Z2hWMgKuOg1gYJF4DPfZ3zJNObtnz3GiQre/4yqRQ+oivazMy4Gc4n6NbuI2Zrqt9t7hdEbx6dBc0oiJLys3sF0nNHZ/33COVfU5Rtz5Sxp2/yEiXpV8nfj7N7kn6wehnc+TAi/tiIvpwjZjAr2ecqQr/W0lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrNZ3iJV60uk6EK6QN7twsKLPNFXh38MAvnEgKME0JU=;
 b=zKbw2r3yxehH0tbV6GH+A8nIxs1RIowfItTQDjwq6m0sN+M2GE1MOpOblQ7FhsEQ1ZV+SKfzs2FuMyXGe3z6X6TVtGqn3WBRY+xUlrtAWYnMer1cWdQg5GZiqbayxGKNTYTIWh4RrcsdyZ9z+Rm+o606PC0zMlNEw0dn84DpIug=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DS0PR12MB6461.namprd12.prod.outlook.com (2603:10b6:8:c7::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.25; Fri, 11 Jul 2025 13:43:18 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8880.034; Fri, 11 Jul 2025
 13:43:18 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v6 09/11] drm/amdgpu: validate the shared bo for tracking
 usage size
Thread-Topic: [PATCH v6 09/11] drm/amdgpu: validate the shared bo for tracking
 usage size
Thread-Index: AQHb8kfEwnvMFUyra0OjyRBbgt20m7Qs1iAAgAAYWdA=
Date: Fri, 11 Jul 2025 13:43:18 +0000
Message-ID: <DS7PR12MB6005F6939CB6B0B2CD901BA3FB4BA@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250711093930.1411470-1-Prike.Liang@amd.com>
 <20250711093930.1411470-9-Prike.Liang@amd.com>
 <efff0172-7df4-4da9-a03d-2041990bb7e9@amd.com>
In-Reply-To: <efff0172-7df4-4da9-a03d-2041990bb7e9@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-07-11T13:43:04.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DS0PR12MB6461:EE_
x-ms-office365-filtering-correlation-id: e56fb388-363e-4a4a-22ee-08ddc080e4f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?U2tzNTB5ZUxXaDlVL1VBTWJUenRmUlZMNHA3ejRmZExlZkxSa1IxdUgvRC8y?=
 =?utf-8?B?dnNNYlZGSnFKbWZxRkZQZitkUXFLWExIaU1iUWMzNmxwNlBVMitTS2JFcXFn?=
 =?utf-8?B?Uk5CTlhGMzRkVVFYVjdvL2I3dTJDVm5EbTVaQktJSFhqbFBUdnhTT0pnMWh0?=
 =?utf-8?B?a3p6T1VMV1N0RkJvc2FLYWJrQUloWXZwK0dUQUlmTFFuZHpmV1F0Uy9BV09r?=
 =?utf-8?B?TFhqalRkNkVzbm9Pd2hpTm45VHkzU20zd2REYTlqSDlFdkVENHRkNzNaalE5?=
 =?utf-8?B?SWp6MWJxS0tLWGJZYzYyY3FiUngyUmgvaEYwemNubW9sZ1Z6MURtQTlXOGUy?=
 =?utf-8?B?aW1TVHBDc0RYc3k1MGVrMERMUTE4UGF4TE9ZSU1XNHl4c3JaZ3dPdkhEeTMz?=
 =?utf-8?B?dGFlblVjWnBxZktOZ1BLZTdGaDl3R0ovWXVKcmRTMlNwQXdiK3EyU1ZPdXlF?=
 =?utf-8?B?YlZuVHR6cUp1RysrQnFZY0tZdm54ejN1MkNRdUY5QjVHUDQ2QS91dDZjUnA2?=
 =?utf-8?B?ZWNoSU5XQUVOemVxRGhZb1lvN3NydWd3aDFsY1pWdi9GbG9hUWZCRGpsT1Vi?=
 =?utf-8?B?U1R4eUt2V0FnSXljdEdER1AwdUxCUkJXR0lwTitnZlhGdTJqWTRCZGlOVmJp?=
 =?utf-8?B?TTloemJKYVFRZllCVEVsQkRrdEt3K0k4MFVWU2ZmWVg5N09SVkpJRHVXM3Jw?=
 =?utf-8?B?bEU5aUcxc0JyQkRCRHBTU3RjclNPUzBIZEVJSHlDbkVZNFhoU2o4SWpqQ3U4?=
 =?utf-8?B?UVpGc291bzBIYWRUQllaZWRLU0FjTVRWQnBkQlV3dldTY05iZDRJd3g2YUhl?=
 =?utf-8?B?ZGEwYWNVcTBKVWMycDIvUUdYWjJvdmx5cC8yYVQ2QVBBcUFOQUFja1ZwMUxk?=
 =?utf-8?B?dzhmZDkrOGFieHBhUmNuMUVQNUZRNGN5OUg0L0Roa3ptNmlqc25qTVAyMXdv?=
 =?utf-8?B?ZGJCN3FZTWQ1MFM4TTBLRnYyTDQ1V2VveHY3bmZYd3lKWjhNS1hKZHFnbVpW?=
 =?utf-8?B?blBncHZOWThUelFXU29GRmREOEpxOWZ5TWlIOVNrNjYyZ0dpYjM4SEREMXVB?=
 =?utf-8?B?aGZrYU5qMFFrZGcySnprUUlDQkVWeEx5K3FHY2Y0RzRvYkpweVY5T0pkRTF2?=
 =?utf-8?B?RVpQcloybWJDNjBoUkpBMlZjSXAzdzUyMS9Nd1RQajhobEZKVkFlK2xYbTVU?=
 =?utf-8?B?ditERW1LVzFHdGRLblgzMmFPa1lKT254Y21oTWN3RDdmQllzL2VJb2duQXRC?=
 =?utf-8?B?YllpVkRnVG9oSzJZbkhNSkUyT25PZmhidXlhQk9PcUtTZXhMQ29KS0gvcVRW?=
 =?utf-8?B?NlhtbnpXKzgxeUpTUG40aTE4NkpOMzlHTjZJelZHdDlNYitNNFUrWDV3cWM3?=
 =?utf-8?B?RzNWSDRWREtzVU1OaldQYnd4Q3ZkR3l3d2lwaWcrdEtkVGRTbVllaHBVL2JF?=
 =?utf-8?B?TE5qSkEvNFhKYVlrZkVBTk5FVU04czRHcmlVOWo3djRyNFdJTENWZzQ0a0hR?=
 =?utf-8?B?MFhIMzFSVHpQV2xqdHBQc2lZQUo4dHprVFFqd1pNVnZCU3JvM1czQ1V3Q2h1?=
 =?utf-8?B?dkRLc0huUjhQNHE2ekhIcGdsek1nZFQybHZHRCt2YTl3eDQvWFoxOXl2NXIx?=
 =?utf-8?B?RHlqRy95VlBUOXRvM0NDM1NjeTdtZUpYdmxXS21La2ZzbjJJYVFDWGk5UUFS?=
 =?utf-8?B?dHd0bzd1WXR2WGpzTW1BYklneUt6MWs0dEFPa3hmMzRodXBEK0N6akhxZG9v?=
 =?utf-8?B?R0F1V1d6dDJEN1hXUWgzazFuWjhtSFlKL25sZkZYSlNCYW5MN3JvMHh2Ynl0?=
 =?utf-8?B?Ry9CTlk1L3N5SXN4WS9jUGtKR2JncFRoU2tvRjdBeFFnZVNlUlppemdKckpS?=
 =?utf-8?B?N0RqNUpES3QzUThWeXBoajZWaElEWUpHd2plMWwxem9xMGk2bjlLTWwzcXE1?=
 =?utf-8?B?OGhRRHN4TTlPa2hCNElpSHJ6eWhLRFMvRGpWZVlDUmNRT3I3aDJ5WXZPa0wy?=
 =?utf-8?Q?4Sv3p4ETgfYAGMHniTNELK74uR34Y0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2lUdGx0cEtUOEJRVTRxcURUejMvbkVadFNkaCtNZkJzMHV2aXoyMzJZWUpR?=
 =?utf-8?B?U054c0NQRWtIQnJUUGtjS2lKQnVNSzFVVXdpaGRWMXRXTC9lYnNSdDh4RnlX?=
 =?utf-8?B?bTBocy9ha2NMbDdoUlNUQzhuaW9xK1NCK3JSN1c0WDBmb1NoYUVEL2gvUkZD?=
 =?utf-8?B?dnlqTENUQWNqenhVMkdmZzQ4ZVl0QTE3ZXo2VUZsN2doM3lBZGNJN01nU1ZG?=
 =?utf-8?B?azlTelRSTDNmVjFWNGdtM2tMNnlEVVd4TzZNS1phMFNXZWo1aCswVWRNcEp1?=
 =?utf-8?B?WS9wanNtQmpzcjBWNndlQVIwQ1pSN21oTVdWV2psZnhUeUNPN0Y3MGxpQXZn?=
 =?utf-8?B?NmlsTDFJN1R4b1FNTlFBNElaM3F3K1JYVEZTTFd2VGdsN3FpWDk0by9vbFZu?=
 =?utf-8?B?TEpaakozdktHL1J2cmEvYjh4bDV4cUZ3QXY4dHhncTh3RjBVQWo4TmhzR0lv?=
 =?utf-8?B?TGRjVmVsY1RKeGhxSzB5ZzVjanRvdGhxbjh5bm5RWVBnZDM4aW1lT0xuNnJP?=
 =?utf-8?B?aFppOXFVVkwzbjh5MysrZFNsclN3ZkEwbjJnNUcyQW1Jc3VuR3dPVXlURUds?=
 =?utf-8?B?NDY0eEk2NW4zbXB0NW1UWmNBbk1vb2t3V2x1RGpNOHd3UFJpd1pTVGR3M1N0?=
 =?utf-8?B?U0N6U2FsamliRjI1Qis0NUpsNVdFQTJsSzBIODRoRHkzVXJ2V1ExZW01QTYz?=
 =?utf-8?B?eDREY1FQUG9EMkE3RHVCQng1VFh5VTI2dTJ2Wm1ObVFiVFNnc2hjWTk3Zk5Q?=
 =?utf-8?B?UWtNSkJJUUlRbDFWZjRISll5QWJBSnN3R1c2Z0E3ZVVSZTI2RTdHNnYvdXhR?=
 =?utf-8?B?ME5VbE5hV0Q3b2cvaUlRRnErSStFWFg4RlJuLy96cm93SjhERjRRTlRtbWV6?=
 =?utf-8?B?YXIrQWN4UVRDZlAweCs3WHFEMUpqU3ZlUVFIL001K0ZmK0huNnluQ2Q3cEZP?=
 =?utf-8?B?bE1zMlNraHE2OTlGQW5TYkQ1OHNLNUkwK29WOU5kTFRRLzZ3b1dQd1dDRS9F?=
 =?utf-8?B?ZzcrVlRTQk9vVVJ5QjdVWlNOVVg2d0ZvbmJKdnRtQllvRHpBRnYwemlzSXJo?=
 =?utf-8?B?anliTUZzczVmeUhWQmdFekhYM2ttbXNCQitJemxSMExMSkR6VHBQSEtOSk5m?=
 =?utf-8?B?OGt4M1BRZU01SjBzdWpFK1J4RFVQSUpSK0d5aFNHcUI4ZXFtREdZREFIbWRH?=
 =?utf-8?B?c3FxamVTWVVrdElLNmR1ZjhkNDRxRVMxaVptZ2g0RFpMelBRb0FCcGhHMlJm?=
 =?utf-8?B?NUd3Y3VzQ0Z5NmpoRG8zdGQxMkFTUHNZK2RPZ3pnR29qZDUyZ24za05EZnFl?=
 =?utf-8?B?NXNGWERJYVp5YXU2UVcrR21CbW4rcU1WZFhvSXcxVVErTlBDQjlWRDc5SnBr?=
 =?utf-8?B?bUdsTmtrTEh2bEVlb0FsdVhFRUhiZUU2K2xMZmZNNmUzeU9yWm9VMWl5TEtx?=
 =?utf-8?B?ZjZRYlJET0ZrNnI5a3oxUkh3WVd3NTVYYk5PODYyOEtyNnJhQzU5NGxYVnZ2?=
 =?utf-8?B?Q3ZOWG81WHo3K3Z4RlpzZCtGc2NTMzBMekN5TWxZTkJWTzl2cVZ0Nm9SU3d5?=
 =?utf-8?B?aXVLaTJRQXZ0blJJQXZuYWVFcVNsSUpGUjFrL21BUHUrTzBnYzZBcS9JQzRL?=
 =?utf-8?B?U25DUEVvTUd1enU5cEJFNlpJMk5FTlpGS1ltWGIvQmJEdDBTbXNHRFlpRlpQ?=
 =?utf-8?B?VDdKKzF1ZzB1ZVczQS9pK1RMU1oxZSswTk1pZ0F5N2JOYU5IWEJxNDVNQjBY?=
 =?utf-8?B?M0RadzBqd2FqKzhHV09yM2MyVUhYWjFNN0U1SmRZTHBXVkQzdkhBQzhlVVlk?=
 =?utf-8?B?UU95cnNOczVsS0JCWnFDZHZXSFZ4a0wvaE1LVDZET1g2cmdwUUQ1TDhvdzky?=
 =?utf-8?B?OHZ0d0NWNm16UzV4N3JvSDlWR2ZTcmpOMXdlUVRaWm1oYzdONlBOaWtPSnJ4?=
 =?utf-8?B?cHdKYjRqWnlyVWdVQkhQQWZwT21KbHcxRjZWaFg4K2NmaU81NitqYzZ6cngw?=
 =?utf-8?B?QTZKN25FR1JkK0ROWVJIV21tRVdBVzArSzdkUUsvd0hkUzhrdHhQYTMwd1ZJ?=
 =?utf-8?B?OGhJaUIzbEMxSFZkektzcGFuLzJKd3NWYWZzUkhWci9aMFJiMG1ROWFvckVY?=
 =?utf-8?Q?dJso=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e56fb388-363e-4a4a-22ee-08ddc080e4f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 13:43:18.5790 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G4YzPq7qBjd4jZA7GGDGGr+FK7YcW2FX5E/LXiMw0GTPtoKEGR0aOFgGtVMbbV5q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6461
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLb2VuaWcs
IENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBGcmlkYXksIEp1
bHkgMTEsIDIwMjUgODoxNCBQTQ0KPiBUbzogTGlhbmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQu
Y29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IERldWNoZXIsIEFsZXhh
bmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
NiAwOS8xMV0gZHJtL2FtZGdwdTogdmFsaWRhdGUgdGhlIHNoYXJlZCBibyBmb3IgdHJhY2tpbmcN
Cj4gdXNhZ2Ugc2l6ZQ0KPg0KPiBPbiAxMS4wNy4yNSAxMTozOSwgUHJpa2UgTGlhbmcgd3JvdGU6
DQo+ID4gSXQgcmVxdWlyZXMgdmFsaWRhdGluZyB0aGUgc2hhcmVkIEJPIGJlZm9yZSB1cGRhdGlu
ZyBpdHMgdXNhZ2Ugc2l6ZTsNCj4gPiBvdGhlcndpc2UsIHRoZXJlIGlzIGEgcG90ZW50aWFsIE5V
TEwgcG9pbnRlciBlcnJvciB3aGVuIHRoZSBCTw0KPiA+IHJlbGVhc2VkIGltcHJvcGVybHkuDQo+
DQo+IENsZWFyIE5BSyB0byB0aGF0LiBZb3UgYXJlIG9idmlvdXNseSB3b3JraW5nIGFyb3VuZCBh
IGJ1ZyBlbHNld2hlcmUuDQpZZXMsIHRoaXMgaXMgYSB3b3JrYXJvdW5kIGZvciB0aGUgdXNlcnEg
UFQgZGVmZXJlbmNlIGltYmFsYW5jZSBpc3N1ZSBhbmQgd2lsbCBkcm9wIHRoYXQuDQoNCj4gUmVn
YXJkcywNCj4gQ2hyaXN0aWFuLg0KPg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUHJpa2UgTGlh
bmcgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMjUgKysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0K
PiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4gPiBpbmRleCBm
MDQyMzcyZDlmMmUuLmE1NzRlZmZkZDNlYyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92bS5jDQo+ID4gQEAgLTMyMSwxMiArMzIxLDI2IEBAIHN0YXRpYyB2b2lk
IGFtZGdwdV92bV9ib19yZXNldF9zdGF0ZV9tYWNoaW5lKHN0cnVjdA0KPiBhbWRncHVfdm0gKnZt
KQ0KPiA+ICAgKi8NCj4gPiAgc3RhdGljIHZvaWQgYW1kZ3B1X3ZtX3VwZGF0ZV9zaGFyZWQoc3Ry
dWN0IGFtZGdwdV92bV9ib19iYXNlICpiYXNlKQ0KPiA+IHsNCj4gPiAtICAgc3RydWN0IGFtZGdw
dV92bSAqdm0gPSBiYXNlLT52bTsNCj4gPiAtICAgc3RydWN0IGFtZGdwdV9ibyAqYm8gPSBiYXNl
LT5ibzsNCj4gPiAtICAgdWludDY0X3Qgc2l6ZSA9IGFtZGdwdV9ib19zaXplKGJvKTsNCj4gPiAt
ICAgdWludDMyX3QgYm9fbWVtdHlwZSA9IGFtZGdwdV9ib19tZW1fc3RhdHNfcGxhY2VtZW50KGJv
KTsNCj4gPiArICAgc3RydWN0IGFtZGdwdV92bSAqdm07DQo+ID4gKyAgIHN0cnVjdCBhbWRncHVf
Ym8gKmJvOw0KPiA+ICsgICB1aW50NjRfdCBzaXplID0gMDsNCj4gPiArICAgdWludDMyX3QgYm9f
bWVtdHlwZSA9IFRUTV9QTF9TWVNURU07DQo+ID4gICAgIGJvb2wgc2hhcmVkOw0KPiA+DQo+ID4g
KyAgIGlmIChsaWtlbHkoYmFzZSkpIHsNCj4gPiArICAgICAgICAgICB2bSA9IGJhc2UtPnZtOw0K
PiA+ICsgICAgICAgICAgIGJvID0gYmFzZS0+Ym87DQo+ID4gKyAgIH0gZWxzZSB7DQo+ID4gKyAg
ICAgICAgICAgcmV0dXJuOw0KPiA+ICsgICB9DQo+ID4gKw0KPiA+ICsgICBpZiAobGlrZWx5KGJv
KSkgew0KPiA+ICsgICAgICAgICAgIHNpemUgPSBhbWRncHVfYm9fc2l6ZShibyk7DQo+ID4gKyAg
ICAgICAgICAgYm9fbWVtdHlwZSA9IGFtZGdwdV9ib19tZW1fc3RhdHNfcGxhY2VtZW50KGJvKTsN
Cj4gPiArICAgfSBlbHNlIHsNCj4gPiArICAgICAgICAgICByZXR1cm47DQo+ID4gKyAgIH0NCj4g
PiArDQo+ID4gICAgIHNwaW5fbG9jaygmdm0tPnN0YXR1c19sb2NrKTsNCj4gPiAgICAgc2hhcmVk
ID0gZHJtX2dlbV9vYmplY3RfaXNfc2hhcmVkX2Zvcl9tZW1vcnlfc3RhdHMoJmJvLT50Ym8uYmFz
ZSk7DQo+ID4gICAgIGlmIChiYXNlLT5zaGFyZWQgIT0gc2hhcmVkKSB7DQo+ID4gQEAgLTM1Myw2
ICszNjcsOSBAQCB2b2lkIGFtZGdwdV92bV9ib191cGRhdGVfc2hhcmVkKHN0cnVjdCBhbWRncHVf
Ym8NCj4gPiAqYm8pICB7DQo+ID4gICAgIHN0cnVjdCBhbWRncHVfdm1fYm9fYmFzZSAqYmFzZTsN
Cj4gPg0KPiA+ICsgICBpZiAodW5saWtlbHkoIWJvKSkNCj4gPiArICAgICAgICAgICByZXR1cm47
DQo+ID4gKw0KPiA+ICAgICBmb3IgKGJhc2UgPSBiby0+dm1fYm87IGJhc2U7IGJhc2UgPSBiYXNl
LT5uZXh0KQ0KPiA+ICAgICAgICAgICAgIGFtZGdwdV92bV91cGRhdGVfc2hhcmVkKGJhc2UpOw0K
PiA+ICB9DQoNCg==
