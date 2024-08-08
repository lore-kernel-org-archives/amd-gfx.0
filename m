Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A89C52D6F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Aug 2024 14:29:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55A7210E00B;
	Thu,  8 Aug 2024 14:29:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0wm9/Qwu";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 966FC10E00B
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Aug 2024 14:29:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+GfFTm2iEafGvgbhCcDZM6ZT3abW/Q0FPMLDag7vjyF4a3mCjZjmqDsEnl9V0IT1JukoYuEMgKKOFss3GvBGqaNk2bjfTgA2FJSMgajggNZiP3HgQ+N20qC3WHRKciF4vLyKAhw4bviHF8hDx6AxNo+w46tl/LHN0nb1g7GEAQ2Z83igAs1sI6CWv8hrq0hnEhDaXHEsT3aNptrDT3LSg1F4jDNBUdiDUfhWk5Jz5fNloPqQesh/+rq15wxbixiqhJT5GQNHEhDuDdLtRRj3k8HsbZvbL3Kwiu96NjO/mBFuZ0pF8gzp4fOoF88lFWeCZSjHvXqcwkmT6h4eEeLGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDi2/gb/j85OvceKBqAJrVwBN+Nf/Tne4zxdYzLD3mU=;
 b=q+uZD5ddbMgCMn9exEtflctZEWHuFzbOQzpRv4riNRhzRZljzn8geUcmdradDLKjE/t53FB0DmnCTFOR804GUR6BjI1ENyjSu+zbTVR/Gj6DGBmZHXkQ4VcZ+fksWfOxpW8JwP9vuUmv1dN+cm7n85kUjjuHe+P/iGLho44Sm926nbunyJ4y+FxPJjCEehLXvD7f9QPpRU4meUc2aQGfDmTfCubGQb0PzqJggpcMQrnmoQ0nUtNQGC+UOtao7K1jubAzKV+W15smi5RPB4thV+75DBck6yrYlq8Rs9c17jBc4uczzzpKyW7jXgN5ngBVEkve6XZASQZBXad0IqVcBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDi2/gb/j85OvceKBqAJrVwBN+Nf/Tne4zxdYzLD3mU=;
 b=0wm9/QwutaZBVZ6jMM624/vhGNKIKWnnGuVN5Jz85dR+EjUnDXfRUtw2mgXhN4RpTmUEK6Mz/es3sDesZG2HxCM8TSgP/3yZ9HvEbnQDH95PuK7sZdR+bRh9czC+wggkkBqQPARpcJWIOxexeZ0rL52yKFknAfUFpGZugfPZZDE=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by SJ2PR12MB8806.namprd12.prod.outlook.com (2603:10b6:a03:4d0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 8 Aug
 2024 14:29:02 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%4]) with mapi id 15.20.7828.021; Thu, 8 Aug 2024
 14:29:02 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdkfd: fix partition query when setting up
 recommended sdma engines
Thread-Topic: [PATCH] drm/amdkfd: fix partition query when setting up
 recommended sdma engines
Thread-Index: AQHa6QlAvNimJC/F50Syrtl/2UJ2hbIcuPgAgACyT0A=
Date: Thu, 8 Aug 2024 14:29:02 +0000
Message-ID: <CY8PR12MB7435D9A2FA7CD2CBB68A964685B92@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20240807203440.1875832-1-Jonathan.Kim@amd.com>
 <663cd1b2-8e7c-47da-869e-e8ddf9d50ec9@amd.com>
In-Reply-To: <663cd1b2-8e7c-47da-869e-e8ddf9d50ec9@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=db7b2eaf-2b37-455c-81f9-d674ea4734a9;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-08-08T14:28:54Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|SJ2PR12MB8806:EE_
x-ms-office365-filtering-correlation-id: d225a018-f8a3-43be-1879-08dcb7b67330
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?N0VXVmFGc2RSbXR1aWlzRnNRRUFzWlYyZGxTV28vOTdmeFBpcWhTVkpLUzhZ?=
 =?utf-8?B?eHJDbFZVRXV4S3VmNUZzRDZvNFROSjV1cC9ENzVCV2RzU25GdE1tb2tPeXhm?=
 =?utf-8?B?alNUZVU1eG9hbkJHQUs4MHphcFBIL2dqTU9vbVFaRW96WlNORjlQRUpCN0wx?=
 =?utf-8?B?anVXSkhkbVdUMS9SZGRENFBhYkFuODlKME5UTVhUMTAzZmJXeTZtTlM5TTNG?=
 =?utf-8?B?UlRORS9lMzZkenBaN0NISklETHVYWnJrZGdIQllZZU5mVFVuNXhtaWFZaXg2?=
 =?utf-8?B?SWZway9XZjE0VUg5cUFpbyt5aGw2cmFTaEI5eUdUSlVIMnBoa00zMnZSVFkz?=
 =?utf-8?B?UGdsOTBEdTlmRTFITk1obkowMGFRTjJ1M2o4UDM4QmxYL2xhZGdXQy9pM2VK?=
 =?utf-8?B?MmNLQkovZnZqQWk5bmpwcG83QlY4UElneWpWd0ZaTzgwNTg5c2xra3pIUlpQ?=
 =?utf-8?B?R2grK2tzVmpZQXZ0S3k5TEg4TStiYUZTY01EakgwNEtCMlFQV0ZnckFVQ3VU?=
 =?utf-8?B?Y0VQSjVFblNSTHNabE8zTDhJQXhYMTl4eG41UWZCUEM4NmFkQVVJWTV6RnFk?=
 =?utf-8?B?QmdHKzl1L2xWTWh6ZzREekQ2WDJMWGYwN1RqY2ZGRVhESmVxc2tuVkJqdExB?=
 =?utf-8?B?UFN6QklYYnhTNkErTGdOSFFES2Zhd09wSFNKTlBOcFhDWnkrbitZbHBkMUNL?=
 =?utf-8?B?NlpNNkR4Q3hMSEhxdGh2Nk1zdFNqZXRIcXhycGpTU0RaeHpzVWRTZjJLQVEy?=
 =?utf-8?B?VS94eWV2RkdVak1TR0MxUHQyZFhYdzdyUnNMMk5UUnVrazNZbGV3dGNVb1Fo?=
 =?utf-8?B?eE1VdkNyeWFaaWtRREp1MUVyUE01ZkU0Ti9vOFhCUDgwZ0U1MHRIYjRXMU9H?=
 =?utf-8?B?Q2wrL29qQlZnd3VTTlFGRHhEYzdsSWxLcVRaYm5qUStGTVRHdHFlallPVmR1?=
 =?utf-8?B?bWdNWU45K3FLSzZ5N1YxZDlsd1ZTam51SXRZZnBEOUZOTUg1ZU1IU3VVWFVR?=
 =?utf-8?B?UThIUGJtSFZLS1h3b3lxTlMvbElXUUl3YWdiSkxKeUp0N3B4SktTK0NEV0FT?=
 =?utf-8?B?N0RFUzhibG5FbUwrUzRlaHBaM1Z4L2t1Nk0reFV2dDZlT0Q5L0RvandaVUR2?=
 =?utf-8?B?RTBidUt3WUlRRjU3ZDNxeHdNNVh6RUxBaGdqdE9UajhKL1FiWDBBZmdpSUUw?=
 =?utf-8?B?by9rRlNZbUlzODlLV2Izdm5lcjd1SjVLdDYwS05NM2FCY2kxNlhFb0ZZYlpE?=
 =?utf-8?B?em1hZytJTmNJc1ljWS9OeFl3UXpXTk01cmViSVZ2eDRaNzRGWmR2N3dGUHVC?=
 =?utf-8?B?SENSMWhpT3prMzhNdWYyc0dVc3NoenNPM2NhbjhYclNqOEFUZUVwNnlBZXp5?=
 =?utf-8?B?WVAzckNWQytDdHV0cEZiME5TUFd0Sjk5V0ZRSWlBOERBQmVuRFVDQUFrdmlL?=
 =?utf-8?B?TG9CZGZkWStNTzhodzdhZ0tDM1hlKzhwYXJ6NTdBK0U1RjREZ1cybGdYT2s0?=
 =?utf-8?B?c3F4cFByMW9UYlFQLzhZWUtYb3hKQ3kydXp0TFk0WkRxQ2o1dFFrb1NoTWYy?=
 =?utf-8?B?K2tZdWtGa2NmQ1MzRWpIZVp2Z3pEYjFSdHFySStsWWtXUHZiT0lWV2ljbjVH?=
 =?utf-8?B?VWJQR3RMTU1wUDdhTDRsblViSk1mVFhTQ05ESy94VmY0bE5rZzVKdWcxUldP?=
 =?utf-8?B?OExkeDY3WU1LUkdyWTZuUFp3YVBuT1RWeTJsZ292WkNlZDF5L2VaRFFNOVFq?=
 =?utf-8?B?YlFMVEppamwvbHEzaFJEdXo1YklxUmhwRXZ1NC9GN2xuejVVYm1tRXBuQ0Qy?=
 =?utf-8?B?SFRqY1ptbWdNY2pOelBNQXc5Ymxhbk1WVnBGNHloNDE2SXFreWMxWEF4L1Fw?=
 =?utf-8?B?cC90TzhtNW1iTmRoMDZMNzVIQlRqVkdUYjZiQjI2Vlk4Zmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXBTem5NYWpFbEh6U0kxeTA2a2NCWHhvOUpHNTF6Mit3alJqaU5RZ1Yybm9J?=
 =?utf-8?B?ekovYXhMVU9raHJ0S1czSGFBWlZkZHc5TFZkTE9OZ3hyTEhneklWRTd3Q1J1?=
 =?utf-8?B?Zjc2Q1hhelluOUxEZ3F4MU5VSnB0amNzMWpmaEJ4ejl5SGtETnVXWSs2ZW53?=
 =?utf-8?B?WFVRSHVaSTlpbEowUlBtcVZxOXpVNWc1WUtsRmR0SWdwN01LWFZLT2ZaaE5v?=
 =?utf-8?B?OEVZWDN0QVZqdkZvTmgyQWM3NnZ5T1JGTlBTZGhEaHYvRUh0WExkbm1MdkdO?=
 =?utf-8?B?WDJBNDNIOENIK0d3ckx4dm5MN0ZDbUNKMmwzV0xPWXVJRTVRK1lkUlEwSTI0?=
 =?utf-8?B?emJRa3A3bUNnTFZra1NJaWZUaHNUbE5YYXpXZ2ttaGRkaG1sWElOL2I4NHBt?=
 =?utf-8?B?UDRMa1BENmsweTd0Z04wM01ScEZCVVRnM3Y4YkpGRWY3RXJDaVloN2ZObXNZ?=
 =?utf-8?B?MEJ5WFBwSC96QWVSWjUxWC8zOHZwS3dtc3d2eHMyWFY0cllBcVZxdXVZdWEv?=
 =?utf-8?B?blkvVDRtTGtabmJ3cFRKNVZPQVU4OWpxenlaOVFoYnZtNldVLzZpRU9FWFlH?=
 =?utf-8?B?ME5uWWRLYXNFdzZGT0JvZ3QyWStXMjNKczI4bENSd1hMb1EvYUhTRXZjeVgy?=
 =?utf-8?B?YmtHYmRObExIQzIzb2ZrYXdXTW55VE9jTHQwNUhwTDhZU245UHh2SDhCZ1Fq?=
 =?utf-8?B?ZUIwUExGUkRFNk9qUHJpZXNCMThLZyt1djVTYWwrbng5OHA5eDB0T1B4bC9y?=
 =?utf-8?B?VzJvUGZIVDdUVEFKNlpMNzF3R2lwQlY3ZjBQbG1kY1ZtYm9TTzc2UjdocUNt?=
 =?utf-8?B?WHRJV1RvMzNVT3ZmRUFLaVl1bktDelNhR2dxa1A2aG1yVnhlT2d5Z2dFcVB5?=
 =?utf-8?B?TCtpOUJkR0hVbkVjRm01ajZlVWFBQXZ4aFlxb2tjZnFEWWxNRUMvL2RRV1c2?=
 =?utf-8?B?dk9DeFBMZ2lMRUhrTFUzYnNCaHNSVlgyWWRKblVMZ0liS0lZMkM0VG1FNGFl?=
 =?utf-8?B?Z2ZOL3NSSUFTK2lncUx6bkVzNGhwN1MybHdxUXg3QVgvWklRRVU0NzlkdTF2?=
 =?utf-8?B?WDlxUm9JQUl6R09tdXhob21QaEt6OFNwMVBDV0owL0doYnVibTc0OHhZY0N3?=
 =?utf-8?B?Y1AyQW1ZQUtuUHlPNDYvSnd6OERWMjM0Q0NiRGZMWENqdWgwRFhyUkdSZlc0?=
 =?utf-8?B?Zk9QM2RXUUZUNGJrSHZRdzJvaUZUOEVja3dWMUZsVFJBLy9XSjlPZ0VIbllJ?=
 =?utf-8?B?RU1RL3RSbWMzdlQ0SDhqR1dueCs2TTBtK0EzdDRsSXpOMk5BWUcvT2o3VWtY?=
 =?utf-8?B?ZStiK3o1QXV1SStzOTJiRU0wdXo2MG1BSzNpamd4N3NFUkNERlY2a2Ftcits?=
 =?utf-8?B?Z1NEV1hwY0crRGFjQ0JBVjU3eE5XdklNaktUY21CbUVNS3lKWWpCaXV0cUtz?=
 =?utf-8?B?S25aMGRRcVg3aGloMnFoWTBTZTNvTmovblA3UnUyeE1idGJKSi9kcFFMV2Jy?=
 =?utf-8?B?RWpuYnpkT01rQ05wSG5jalMwaXFIbUZJNjRtWGtUYjNRa1JjRTVrUE5oQllM?=
 =?utf-8?B?dWVURTlsbmY4N3JwZVBhTHdCcDVxbE8xajV3Wnloa05lOG0xUnZoUm9Bczdt?=
 =?utf-8?B?ZnlNb3pkTXNBdmNROEtVek9TUUJUVWhmWVhkQ0kvU2VXUXVCRjBYcG1VL095?=
 =?utf-8?B?UjJsRHpxUTJzc25BNW1zdlllM3BZN05UNVJFd09HaHpnb1J4ZkhjWEx2ZVRi?=
 =?utf-8?B?U2pjeXd2NHNyenNOc1hwOEk2TVcyMUZibmJwRVlxVUR3a2paVDVuK3JSc0Rx?=
 =?utf-8?B?bTUrdDBnMXlvVVArRE5YenB0dG1IaU1veDJiMlZXMDZLTktGOUJLUW5DWm1z?=
 =?utf-8?B?STVhYVp0dGx5T0JXS3hIWEt2Nk5LZ1VUWGpLeVMrTkQxeWcxY1QydEMrdUNZ?=
 =?utf-8?B?NWFhWWxjdnlrRFcvL2F2Y2pUZFA5WUVLUTZQR0k4V00zdWxvNnBTRjZjZzc2?=
 =?utf-8?B?YVJYaTRlYmFxcEYza1Mva3gveHdqaERpTk56UzNlamdRRjFOd2UxTExESCsy?=
 =?utf-8?B?MTNpUnZZMW5IMkFEZ0ticE9mN29VVmhjaFg1OFA5MWZzQlh1MW1xemIwSHhx?=
 =?utf-8?Q?qSk0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d225a018-f8a3-43be-1879-08dcb7b67330
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 14:29:02.3692 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TW9YtlE0m79YbjBId7EUDphpGRasqUIHmgW6i/OYh5uVI67VZI5B+orkQO1KxFhL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8806
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXphciwg
TGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCA3LCAy
MDI0IDExOjQ2IFBNDQo+IFRvOiBLaW0sIEpvbmF0aGFuIDxKb25hdGhhbi5LaW1AYW1kLmNvbT47
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBLdWVobGluZywgRmVsaXggPEZl
bGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRrZmQ6
IGZpeCBwYXJ0aXRpb24gcXVlcnkgd2hlbiBzZXR0aW5nIHVwDQo+IHJlY29tbWVuZGVkIHNkbWEg
ZW5naW5lcw0KPg0KPg0KPg0KPiBPbiA4LzgvMjAyNCAyOjA0IEFNLCBKb25hdGhhbiBLaW0gd3Jv
dGU6DQo+ID4gV2hlbiB1c2VycyBkeW5hbWljYWxseSBzZXQgdGhlIHBhcnRpdGlvbiBtb2RlIHRo
cm91Z2ggc3lzZnMgd3JpdGVzLA0KPiA+IHRoaXMgY2FuIGxlYWQgdG8gYSBkb3VibGUgbG9jayBz
aXR1YXRpb24gd2hlcmUgdGhlIEtGRCBpcyB0cnlpbmcgdG8gdGFrZQ0KPiA+IHRoZSBwYXJ0aXRp
b24gbG9jayB3aGVuIHVwZGF0aW5nIHRoZSByZWNvbW1lbmRlZCBTRE1BIGVuZ2luZXMuDQo+ID4g
SGF2ZSB0aGUgS0ZEIGRvIGEgbG9ja2xlc3MgcXVlcnkgaW5zdGVhZCB0byBhdm9pZCB0aGlzLg0K
PiA+IFRoaXMgc2hvdWxkIHdvcmsgc2luY2UgdGhlIEtGRCBhbHdheXMgaW5pdGlhbGl6ZXMgc3lu
Y2hyb25vdXNseSBhZnRlcg0KPiA+IHRoZSBLR0QgcGFydGl0aW9uIG1vZGUgaXMgc2V0IHJlZ2Fy
ZGxlc3Mgb2YgdXNlciBvciBzeXN0ZW0gc2V0dXAuDQo+ID4NCj4gPiBGaXhlczogYTBmNTQ4ZDc4
NzFlICgiZHJtL2FtZGtmZDogYWxsb3cgdXNlcnMgdG8gdGFyZ2V0IHJlY29tbWVuZGVkDQo+IFNE
TUEgZW5naW5lcyIpDQo+ID4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gS2ltIDxqb25hdGhhbi5r
aW1AYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X3RvcG9sb2d5LmMgfCAyICstDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF90b3BvbG9neS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X3RvcG9sb2d5LmMNCj4gPiBpbmRleCA0MDc3MWY4NzUyY2IuLjhmZWU4OWI4ZGQ2NyAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9neS5jDQo+ID4gQEAg
LTEyODcsNyArMTI4Nyw3IEBAIHN0YXRpYyB2b2lkDQo+IGtmZF9zZXRfcmVjb21tZW5kZWRfc2Rt
YV9lbmdpbmVzKHN0cnVjdCBrZmRfdG9wb2xvZ3lfZGV2aWNlICp0b19kZXYsDQo+ID4gICAgIGlu
dCBudW1feGdtaV9ub2RlcyA9IGFkZXYtPmdtYy54Z21pLm51bV9waHlzaWNhbF9ub2RlczsNCj4g
PiAgICAgYm9vbCBzdXBwb3J0X3JlY19lbmcgPSAhYW1kZ3B1X3NyaW92X3ZmKGFkZXYpICYmIHRv
X2Rldi0+Z3B1ICYmDQo+ID4gICAgICAgICAgICAgYWRldi0+YWlkX21hc2sgJiYgbnVtX3hnbWlf
bm9kZXMgJiYNCj4gPiAtICAgICAgICAgICAoYW1kZ3B1X3hjcF9xdWVyeV9wYXJ0aXRpb25fbW9k
ZShhZGV2LT54Y3BfbWdyLA0KPiBBTURHUFVfWENQX0ZMX05PTkUpID09DQo+ID4gKyAgICAgICAg
ICAgKGFtZGdwdV94Y3BfcXVlcnlfcGFydGl0aW9uX21vZGUoYWRldi0+eGNwX21nciwNCj4gQU1E
R1BVX1hDUF9GTF9MT0NLRUQpID09DQo+ID4gICAgICAgICAgICAgICAgICAgQU1ER1BVX1NQWF9Q
QVJUSVRJT05fTU9ERSkgJiYNCj4NCj4gUmVwbGFjaW5nIHdpdGggKGdwdS0+a2ZkLT5udW1fbm9k
ZXMgPT0gMSkgbWF5IGJlIGJldHRlci4NCg0KVGhhbmtzLiAgVGhhdCBzZWVtcyBhIGxvdCBzaW1w
bGVyLiAgQWxzbyBhbm90aGVyIGFzc3VtcHRpb24gaXMgdGhhdCBhbGwgMTQgU0RNQSB4R01JIGVu
Z2luZXMgYXJlIHByZXNlbnQsIGJ1dCB0aGF0IG1heSBvciBtYXkgbm90IGFsd2F5cyBiZSB0aGUg
Y2FzZSBmb3IgYWxsIGRHUFUgU1BYLW1vZGUgZGV2aWNlcy4NCkknbGwgYWRkIHRoYXQgYXMgYSBo
YXJkIGNvbmRpdGlvbiBjaGVjayBhcyB3ZWxsLg0KDQpKb24NCg0KPg0KPiBUaGFua3MsDQo+IExp
am8NCj4NCj4gPiAgICAgICAgICAgICAoIShhZGV2LT5mbGFncyAmIEFNRF9JU19BUFUpICYmIG51
bV94Z21pX25vZGVzID09IDgpOw0KPiA+DQo=
