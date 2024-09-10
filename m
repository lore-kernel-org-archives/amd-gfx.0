Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56890EB64DE
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Sep 2024 05:42:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6BC810E4DD;
	Tue, 10 Sep 2024 05:42:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RPW3OtBc";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DD8010E4DD
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Sep 2024 05:42:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abNyRqp+/OaoD1cyaYHt3xT99xPaBQnVa7vYC+GxHGOK8ZXx0ODhj8pj8OfeLn41TthQ7q0kin/QcbPpjcY4kVWbGBSMcTknZupwjjiIqBzSRmAxge6uz63EfsnDxgVXgnOPo+i/HF0gEoOsvRV/3lNgnW2apOwedaapyCbkP/wjhdo8oHx+WkGOV59KW3FMJm9rZO7tgI/Tw8gwRHWN+BeSm/ImBWEEDzxDzzVmA687Durx6WxxseqyWC45hxQU3SgWbRXpuS0oLEjsoqiluGnsEujOrJcc9DIvTgxYGdCcqgLdV+v/JY9T6GGaOHK76ppYWObyWwiZ6yl6ZcLq+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/IyY75662kI3mCBHaGnLe97ImTJhX0WROXCgRsafQ4=;
 b=vDS9rV6BcEYRugDfxIRRwLHiHxZLbiAnNfa7yUN6Kq1611sF5Y7PhZD3pPoqbDHZwD89acfE+7QEbT2EQrtn6REX8CpivxYlX3sVZGWG6GuNRAzjVImRJEfX3TmL2LXXt+qZVLhmWuoPUwqVZOBSFC8IUszOAOt6p4NBAgyBBPbXKymeouChdDjWU6cLIYOxVUxRm2j2tjfJdyfZ+VjY8tEPKk6GxJw0JE8za5FH4WImB+VK9gtl9aw8rxickt+AZL+q7aP3kJkjBVtRKJXATEWn3vkoh7XqBC568m2h/xIOU/Syxd0jjAc0FmMYCUzzQO5ZA5yaFo6nqw+29vuQIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/IyY75662kI3mCBHaGnLe97ImTJhX0WROXCgRsafQ4=;
 b=RPW3OtBcKhS2Or6Qc+YlCq4mhGYqdsAwJIkBHhOlUIxq7C4qs+4dZmUDxTlI6th+BlckUCV4O7164QA+uSLhqrUFonZi7SSxYs4Nshw/jWzuALZHicAQ7I0SdsqLrtioS64CsBLAjaSe9rIQvUl1Vsqlr7OuY2v7sJGhfXMQ5xc=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 LV8PR12MB9408.namprd12.prod.outlook.com (2603:10b6:408:208::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.25; Tue, 10 Sep 2024 05:42:01 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.7918.031; Tue, 10 Sep 2024
 05:41:59 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: update suspend status for aborting from
 deeper suspend
Thread-Topic: [PATCH] drm/amdgpu: update suspend status for aborting from
 deeper suspend
Thread-Index: AQHa/Q/9qItUk6VUqUSLe/ZtzNgwobJI0iLQgAI5rwCAA/tWMIAAlyUAgADtiIA=
Date: Tue, 10 Sep 2024 05:41:59 +0000
Message-ID: <DS7PR12MB6005F403EFECD8B9E4D589DBFB9A2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20240902081311.2918278-1-Prike.Liang@amd.com>
 <DS7PR12MB600580C6E52BE6734FD7F0F7FB9D2@DS7PR12MB6005.namprd12.prod.outlook.com>
 <BN9PR12MB5146FB172036F9601B38C3E6F79E2@BN9PR12MB5146.namprd12.prod.outlook.com>
 <DS7PR12MB60057926E8C172D3EB5A332EFB992@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CADnq5_M4R5-fFQPeMe6XxoovQdL-7z1zecnRDyr7pNXwe5=UOQ@mail.gmail.com>
In-Reply-To: <CADnq5_M4R5-fFQPeMe6XxoovQdL-7z1zecnRDyr7pNXwe5=UOQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=27280172-dc32-4710-b313-7032d33ea3af;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-10T05:33:34Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|LV8PR12MB9408:EE_
x-ms-office365-filtering-correlation-id: d1f6c834-d1e9-44f1-5e74-08dcd15b4a09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NlNnK3dpQUhQem9zVkpzV3NTVk9SRm1CaUI4WlAvdkk1VlBuV1YzWXFUMzVS?=
 =?utf-8?B?Sy9xcDBSOTVkRTlSVUFMcFRtaVJCbjdGMDdPcndiMnQ3Z3VvTFdPQy91OUkz?=
 =?utf-8?B?S1hkbHlIMUR0K3YweElKWnR3TVFqbzR6aTlyeVMwenNYZUhkRmxoVk9zak9U?=
 =?utf-8?B?MFpIdmZyZTNNN1FIM3BYSzFRaG8xVjd5SFU5Ky8xemQ0RFEzV09pZVEwa1J5?=
 =?utf-8?B?R0xQWFZGWDljMHZkNTQrSDhVQjluNjIwaVo4WEtjcGx2aS82bUo2Y3luME56?=
 =?utf-8?B?V3BqRFdGcmtGL0lEQ3hOUUNRK3FVQzBPZlFjN3lZdFdMRGxFbEllNDBFUit4?=
 =?utf-8?B?Sk4yaDgzcWZMMHVoTGxBeUxjRzFuNjZYZ0NrYmx4K2MwcGJNSGs1SXBXVVpq?=
 =?utf-8?B?V1ZMSFp5M1BZY05NVjI0cGhNU00wRUc4VkRrVmtycldsRjdYVm95b3FTaGJF?=
 =?utf-8?B?UmZVeDVyQWk3SFd1OUptNGFMWXVxSXNjSzN5NStOT0ZYTVNBdlZQbk1odFNu?=
 =?utf-8?B?dVZibFFydElkNWFjS081bHBIMGgzQW5nOHczeFU2U3EwVlF6RjZXQWV1YlJr?=
 =?utf-8?B?akxIeWgzTWF1L2ErcVpwN0J1bitUbW9RdGhPZEllWEJ0eGp0R2RPOWhIUFBq?=
 =?utf-8?B?M1hJYXlYK1B3bXBoa3dDQ3IvYmlEU2RJdk9mMS91RFc0c1ZUL2hPSWZodmty?=
 =?utf-8?B?Um10RGJEd0MzYkluSTgweEZKaC8yNTJ5aS9vV1A4a2d2Mm1wZkNrcHZGUEV1?=
 =?utf-8?B?Q3NJWFhSUnFqOGpQODFvZnlhQjFNZ0E2dGhnUHp1SGdZRlA2aWNxampZY3po?=
 =?utf-8?B?TEFxQ2s0RlEzUTBObUVyT2lycWYyZDRlMUtLdlBMSzZHQnZZZUw0aUZhZWRD?=
 =?utf-8?B?eUREbjlpY1UyVThhV01RY014Z09HOTloTWZnSzhwQ0RoWFk1bXo1Y3VUUEhJ?=
 =?utf-8?B?d0RPcUp0QzBCWFliL3A5dVdkZmI5a2lsYThwYytHRFd3ZU84c3BhcXcybHFl?=
 =?utf-8?B?amZrOWw5cG1KWFhWclJBMUpQc2xIbisvL2MrU0RHYTJCZXRGcWg1RWZpcFZT?=
 =?utf-8?B?SjlpU09Fa01tSlIzOE8rNGFYd1VTbzBTVTJhV0VRRmxqSG5wd0hrbFlsbTFN?=
 =?utf-8?B?SlkzMk1zTmRteUM4WWNvZ0xFWDl4QlVlMER0UDEvTHhja3ZZdi8yaXRRc2lv?=
 =?utf-8?B?NG95WGlBVGlrUHdFaE9xWkZmSFVrbXdHK3prbEhpTFcrQTdPOHN5TFEyc1Q5?=
 =?utf-8?B?VWxFekdOYlg5RHdLN0p6SUEyUUJJR25CUlY1WlZzYmZYTUFiQmx5UzdyNnR5?=
 =?utf-8?B?Z3dIcHJaUFhmRlRBcVBFSVp4UUtkUitqL2d3L0I0RXBNTHFXUDhSdWEraC9Z?=
 =?utf-8?B?WHdwRWVXdEF0ejVCOG55b2FZSWZrbDhWbEY3Q0o3NG4zWm5EQ05kcFlKVFhJ?=
 =?utf-8?B?YnczVnNhME1sVWl6SFhQK0NHTFRRLzhJODRmZUQ0eDBlQ0sxZjRpTTJkRlAy?=
 =?utf-8?B?Z3JncTFWc3ViZVkramtZV2h2R0Z6S3Z0eW90cEZWWHdPUERRR0wwTm0rV1pw?=
 =?utf-8?B?WDFxTThRSk5sR1M2Q0VQQkE5dnhYSnRzLzVLbjlFZHZZY0M4Z0tGUXZ0Uk42?=
 =?utf-8?B?V1lxRTVQQjJmY09WMnUzV0kwd2wxN0p3MHZ1bTdFb0o1ejllVklUb2VJci9z?=
 =?utf-8?B?SVpYYWZPZVdFSjhIV05udlVZWkdhQzI5RE5JVlpXeFdqdGViREthV2dIU3NV?=
 =?utf-8?B?dzMwUllSYmxRWDVEamoveXNrN1paeEpVTm1mOTNHeTJ0Q1pxeWJyZTRLcnha?=
 =?utf-8?B?QTlyaEgwaHlPZEkzSTlRL1UrNnc1ZGNyeU0zc3ErTE5aT3Bhd1NkU1ZuclNl?=
 =?utf-8?B?cWEyQ2s5YWFxdzh5bSszYUs4TURYb1pzdzRGWXU2UldEY0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzZSaVZPWGZ0UkRXUTlBdy9qYS9JZlkzc1ZMa0p6Ti95NFpjbU5PK2czWjFD?=
 =?utf-8?B?Wk1DT3JtRFNTNWlTNkJCdlRwV1VkWHQrUHNmVkpCT0F3VHljbkJzb2thazk1?=
 =?utf-8?B?OHppWThhaWZrS2swUitSQ2JvREdiaXdyazJoZ0NFeDF2RkovclQrcGJLZTgx?=
 =?utf-8?B?WkdaYnZZK21YMlFZbnIvUWxUTU5UWHpaczRNU1JGajUxMzcyQmY4WTg0OGtC?=
 =?utf-8?B?aWpTZTl1clpaRHl4bHNIUzRuaGM1RVBBcVpVMG1Sa05MUzlPcUFRZmQvWW1V?=
 =?utf-8?B?VE1MQVlHRURHQk11b2ZiUGk3NFdkRFNCTm5MMUNHVzczT0lzdTR1bDlJMzBw?=
 =?utf-8?B?ZUdDNjQ0SS9JaXNpNzFkM1pwd0dxa2t2SGtlVzNXNzVuQStkU29FaU5vSXFH?=
 =?utf-8?B?SHRFQzFiRXVGUlo0bWlMcFY1YUczWkRuLzBXTzFWdXoxVWpBaFhTMU4ycTh6?=
 =?utf-8?B?TmViVUNndHRrK2tjbVQ4WWcvcXhYMWwwSWxBTmRRUW1tSHZCL29UdzJqak8v?=
 =?utf-8?B?Nkxna1l4SFFuZGh4MmhPUlQ0N3hwS0w4VHlKcGZwQkZabjcxTGpTTU9ZakJM?=
 =?utf-8?B?aEVlTlZjWXVYMFJNN2tlMFpuV29lN3U3ZjNHQnhtVCtQOFdaSm5UT0RxeFpv?=
 =?utf-8?B?RnVWR1Fqa21PTUp3YmMza3RnZDFoeGE0di90a29OY0tGVHlIdVpSdXhQV3FB?=
 =?utf-8?B?OXovc2p2U2JKMVNQbzJESStnNVdOV1kzQ2NpbHRlT3N3LzFWSlZrTVU3OWN5?=
 =?utf-8?B?RHBxb1FjQzlOK3pLZ2c2SXBQSkpNMkF5MVluZ1VFdm9ZS21wb2xRNVpvMFh1?=
 =?utf-8?B?VHVsSXVhUmtDSHdZWXdFYmROY1lra00vQVN1ckZqS0NIcnIwcERTRXpKTHJM?=
 =?utf-8?B?bm1QNmpuWXVNd3Fva0ZjUHFYbjlUdU1aZEdTc0JRenQwWGtTSHRCUmpuUzlK?=
 =?utf-8?B?QW1XZVErL3dmMlQ1QkcvRnhiQzlQb0ppbXlVQWNYQjVRUVJ4WnpBQWZCYndT?=
 =?utf-8?B?TmR6TGpwb3hTY2NsWTcwMnIrR0dTNGJ1WFNRVzBSTVBIK3ZteTJMUjJQRHJj?=
 =?utf-8?B?TWkzYnJ5VTFsUGpPV0pUbktIcDFkNFh2Sk56V2QvMVBvaGZNbUxHQlBZdHl0?=
 =?utf-8?B?OVhZYnV6NndWWmhQL1g0L0hrZ1JESEdaSjFWY2dBaXlyT1NsL2wxQ2dvZHFm?=
 =?utf-8?B?ckxCZ0MwZXJuMktTTnF2NWhSbDNLeVIxZDFkbFArV2JBK1M0enlUcWpNekhn?=
 =?utf-8?B?ZEcyOURHMU45T0h6ZDBNcUluNFRmSmY2RXErM2lWcHhuVjRYaHEzSWI3RENo?=
 =?utf-8?B?ZFRHbEpSbjNKN25YRU1kbWUzbXNwRE9uWnVKbWJhc0dUOXQxMFRjV1FwVmlN?=
 =?utf-8?B?OXdzU2tKWTlteWlQd2l2eFd5Ni9qWFoxNG1SYWovekFlaU03VXhMUHNJaDlq?=
 =?utf-8?B?cmNsVkZKVDdHM3hEVEZDSUtpMndhT0tLWDZBdnJzbHM0U3F5dUpQb1NGM1Zl?=
 =?utf-8?B?ck1XTFdDSzJtMHR3alFBTHU0ZEI2ZFYxWUZXdzR6SU5xbExsclpvYVRWMHhn?=
 =?utf-8?B?SXlvQjE3alArVFlRQk9UYWFnRDZzZmttRWpwNjBTQVJheHkweDFHRmVGcUFs?=
 =?utf-8?B?UEZwTVNGQXIxaUNBNktyWjV6S2hUWGNhdUtHY2NnZVJ1bi9KVmVTYnZFVW5I?=
 =?utf-8?B?U29XMUduVmloeFhJT0svUVlxNDNldTFYOWNaM1BIUVVMZktXUmFseEFuVjB1?=
 =?utf-8?B?VjNLU01uS3V3ZFlwa1JHS09FY2FWTVc1NUNHV3ZORWtCc0pmcFpKTjJXbWxQ?=
 =?utf-8?B?TVVYa0x0K0NRUkMreGdTMTVvUG5GRkl4alIrQm9qQkV4MlkwQVFGd25zMVRN?=
 =?utf-8?B?VlRDT2V6NGpYS3pOcXZnd1M3Rkp2Y05zMVVtOUFCamVzZVpwWG4xZlhUWG53?=
 =?utf-8?B?VTZCZkZhRmpKQURlVDJPdWZTaXZ5NFJMZWROQkhKL1VYbjF0OHdCSXRsWnJC?=
 =?utf-8?B?VDl1N2ttUVZrUENJcS9PZGZaZ1RxSzVpR3ZvbGNpczQxVzZoeDEydEdVNUpn?=
 =?utf-8?B?eTlvdDRRMk9lcjJZSTBjOTdIaWFrMUwrQ21OMlR5NmRnU2I1bGRaL1lSVGJw?=
 =?utf-8?Q?6uxI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f6c834-d1e9-44f1-5e74-08dcd15b4a09
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 05:41:59.4037 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ePs+EluRraHn86tUfHmfYiiWnjEOU+1k1BQh7j9JzBIjKSWNxE6EAgzS4ISNJCXt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9408
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
Cg0KWWVzLCB0aGFuayB5b3UgZm9yIHRoZSBzdWdnZXN0aW9uLiBUaGVyZSB3aWxsIGJlIGEgc2Vw
YXJhdGUgcGF0Y2ggZm9yIGNsZWFuaW5nIHVwIHRoZSBzZXR0aW5nIGFuZCBjaGVja2luZyBvZiB0
aGUgc3VzcGVuZF9jb21wbGV0ZSBmbGFnLg0KDQpUaGFua3MsDQpQcmlrZQ0KDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21h
aWwuY29tPg0KPiBTZW50OiBNb25kYXksIFNlcHRlbWJlciA5LCAyMDI0IDExOjIzIFBNDQo+IFRv
OiBMaWFuZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+IENjOiBEZXVjaGVyLCBBbGV4
YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBhbWQtDQo+IGdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogdXBkYXRlIHN1
c3BlbmQgc3RhdHVzIGZvciBhYm9ydGluZyBmcm9tDQo+IGRlZXBlciBzdXNwZW5kDQo+DQo+IE9u
IE1vbiwgU2VwIDksIDIwMjQgYXQgODo1OOKAr0FNIExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdA
YW1kLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gQU1EIElu
dGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KPiA+DQo+ID4NCj4gPiBQcmV2aW91c2x5LCB0aGUg
UzMgcHJvY2VzcyBhYm9ydGVkIGJlZm9yZSBjYWxsaW5nIHRoZSBub2lycSBzdXNwZW5kLCBhbmQg
dGhpcw0KPiBpc3N1ZSB3YXMgc3VjY2Vzc2Z1bGx5IHNvcnRlZCBieSBjaGVja2luZyB0aGUgc3Vz
cGVuZF9jb21wbGV0ZSBmbGFnLg0KPiBIb3dldmVyLCB0aGVyZSBhcmUgbm93IHNvbWUgUzMgc3Vz
cGVuZCBjYXNlcywgc3VjaCBhcyBwbV90ZXN0DQo+IHBsYXRmb3JtL2NvcmUgbW9kZSwgd2hpY2gg
YWJvcnQgdGhlIFMzIHByb2Nlc3MgYWZ0ZXIgdGhlIG5vaXJxIHN1c3BlbmQuIEluDQo+IHRoZXNl
IGNhc2VzIG9mIGFib3J0LCB0aGUgaXNzdWUgY2Fubm90IGJlIHNvcnRlZCBvdXQgYnkgc2V0dGlu
ZyB0aGUNCj4gc3VzcGVuZF9jb21wbGV0ZSBmbGFnIGluIHRoZSBub2lycSBzdXNwZW5kIGNhbGxi
YWNrLCBhbmQgaXTigJlzIGZpbmUgdG8gdXNlIHRoZQ0KPiBNUDAgU09MIHJlZ2lzdGVyIGRpcmVj
dGx5IHRvIGRldGVybWluZSB3aGV0aGVyIHRvIHJlc2V0IHRoZSBHUFUgb24gcmVzdW1lLg0KPiBI
b3dldmVyLCBvbiB0aGUgR0ZYOSBzZXJpZXMsIHRoZSBkcml2ZXIgc3RpbGwgbmVlZHMgdG8gcmVs
eSBvbiB0aGUNCj4gc3VzcGVuZF9jb21wbGV0ZSBmbGFnIHRvIGRldGVybWluZSB3aGV0aGVyIGl0
IG5lZWRzIHRvIHNraXAgcmVwcm9ncmFtbWluZw0KPiB0aGUgY2xlYXIgc3RhdGUgcmVnaXN0ZXIg
dmFsdWVzIGR1cmluZyByZXN1bWUgZnJvbSBzdXNwZW5kIGFib3J0IGNhc2VzLCBzbw0KPiBub3cg
aXQgc291bmRzIHRoYXQgdGhlIHN1c3BlbmRfY29tcGxldGUgZmxhZyBjYW5ub3QgYmUgY29tcGxl
dGVseQ0KPiByZW1vdmVkLg0KPg0KPiBDYW4gd2UganVzdCBzZXQgdGhlIHN1c3BlbmRfY29tcGxl
dGUgZmxhZyBiYXNlZCBvbiB0aGUgU09MIHJlZ2lzdGVyIHJhdGhlcg0KPiB0aGFuIGJhc2VkIG9u
IHdoYXQgZnVuY3Rpb25zIGhhdmUgYmVlbiBjYWxsZWQ/ICBNYXliZSBhcyBhIGZ1dHVyZSBjbGVh
bnVwPw0KPiBUaGlzIGxvZ2ljIHNlZW1zIGZyYWdpbGUgYW5kIEknbSB3b3JyaWVkIGl0IHdpbGwg
Z2V0IGFjY2lkZW50bHkgYnJva2VuLiAgRm9yIG5vdw0KPiB0aGUgcGF0Y2ggaXM6DQo+IEFja2Vk
LWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+DQo+IEFsZXgN
Cj4NCj4gPg0KPiA+DQo+ID4NCj4gPiBUaGFua3MsDQo+ID4NCj4gPiBQcmlrZWMNCj4gPg0KPiA+
DQo+ID4NCj4gPiBGcm9tOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFt
ZC5jb20+DQo+ID4gU2VudDogU2F0dXJkYXksIFNlcHRlbWJlciA3LCAyMDI0IDE6MzQgQU0NCj4g
PiBUbzogTGlhbmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcNCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiB1cGRh
dGUgc3VzcGVuZCBzdGF0dXMgZm9yIGFib3J0aW5nDQo+ID4gZnJvbSBkZWVwZXIgc3VzcGVuZA0K
PiA+DQo+ID4NCj4gPg0KPiA+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBBTUQgSW50ZXJuYWwg
RGlzdHJpYnV0aW9uIE9ubHldDQo+ID4NCj4gPg0KPiA+DQo+ID4gQ2FuIHlvdSBlbGFib3JhdGUg
b24gaG93IHRoaXMgZmFpbHM/ICBTZWVtcyBsaWtlIG1heWJlIHdlIHNob3VsZCBqdXN0IGdldA0K
PiByaWQgb2YgYWRldi0+c3VzcGVuZF9jb21wbGV0ZSBhbmQganVzdCBjaGVjayB0aGUgTVAwIFNP
TCByZWdpc3RlciB0bw0KPiBkZXRlcm1pbmUgd2hldGhlciBvciBub3Qgd2UgbmVlZCB0byByZXNl
dCB0aGUgR1BVIG9uIHJlc3VtZS4NCj4gPg0KPiA+DQo+ID4NCj4gPiBBbGV4DQo+ID4NCj4gPg0K
PiA+DQo+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gPg0KPiA+IEZyb206
IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gPiBTZW50OiBUaHVyc2RheSwg
U2VwdGVtYmVyIDUsIDIwMjQgMzozNiBBTQ0KPiA+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZyA8YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+DQo+ID4gQ2M6IERldWNoZXIs
IEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gPiBTdWJqZWN0OiBSRTog
W1BBVENIXSBkcm0vYW1kZ3B1OiB1cGRhdGUgc3VzcGVuZCBzdGF0dXMgZm9yIGFib3J0aW5nDQo+
ID4gZnJvbSBkZWVwZXIgc3VzcGVuZA0KPiA+DQo+ID4NCj4gPg0KPiA+IFtBTUQgT2ZmaWNpYWwg
VXNlIE9ubHkgLSBBTUQgSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldDQo+ID4NCj4gPiBBY2Nv
cmRpbmcgdG8gdGhlIENocm9tZU9TIHRlYW0gdGVzdCwgdGhpcyBwYXRjaCBjYW4gcmVzb2x2ZSB0
aGUgUzMgc3VzcGVuZA0KPiBhYm9ydCBmcm9tIGRlZXBlciBzbGVlcCwgd2hpY2ggb2NjdXJzIHdo
ZW4gc3VzcGVuc2lvbiBhYm9ydHMgYWZ0ZXIgY2FsbGluZw0KPiB0aGUgbm9pcnEgc3VzcGVuZCBh
bmQgYmVmb3JlIGV4ZWN1dGluZyB0aGUgX1MzIGFuZCB0dXJuaW5nIG9mZiB0aGUgcG93ZXINCj4g
cmFpbC4NCj4gPg0KPiA+IENvdWxkIHRoaXMgcGF0Y2ggZ2V0IGEgcmV2aWV3IG9yIGFja25vd2xl
ZGdtZW50Pw0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IFByaWtlDQo+ID4NCj4gPiA+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBMaWFuZywgUHJpa2UgPFByaWtlLkxpYW5n
QGFtZC5jb20+DQo+ID4gPiBTZW50OiBNb25kYXksIFNlcHRlbWJlciAyLCAyMDI0IDQ6MTMgUE0N
Cj4gPiA+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiA+ID4gQ2M6IERldWNo
ZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IExpYW5nLCBQcmlrZQ0K
PiA+ID4gPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+ID4gPiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9h
bWRncHU6IHVwZGF0ZSBzdXNwZW5kIHN0YXR1cyBmb3IgYWJvcnRpbmcgZnJvbQ0KPiA+ID4gZGVl
cGVyIHN1c3BlbmQNCj4gPiA+DQo+ID4gPiBUaGVyZSdyZSBzb21lIG90aGVyIHN1c3BlbmQgYWJv
cnQgY2FzZXMgd2hpY2ggY2FuIGNhbGwgdGhlIG5vaXJxDQo+ID4gPiBzdXNwZW5kIGV4Y2VwdCBm
b3IgZXhlY3V0aW5nIF9TMyBtZXRob2QuIEluIHRob3NlIGNhc2VzIG5lZWQgdG8NCj4gPiA+IHBy
b2Nlc3MgYXMgaW5jb21wbGV0ZSBzdXNwZW5kc2lvbi4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBQcmlrZSBMaWFuZyA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4g
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMgfCAxMCArKysrKystLS0tDQo+ID4g
PiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPiA+
DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYw0K
PiA+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jDQo+ID4gPiBpbmRleCA4
ZDE2ZGFjZGMxNzIuLmNmNzAxYmI4ZmM3OSAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3NvYzE1LmMNCj4gPiA+IEBAIC01ODcsMTEgKzU4NywxMyBAQCBzdGF0aWMgYm9vbCBz
b2MxNV9uZWVkX3Jlc2V0X29uX3Jlc3VtZShzdHJ1Y3QNCj4gPiA+IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpDQo+ID4gPiAgICAgICAgKiAyKSBTMyBzdXNwZW5kIGFib3J0IGFuZCBUT1MgYWxyZWFkeSBs
YXVuY2hlZC4NCj4gPiA+ICAgICAgICAqLw0KPiA+ID4gICAgICAgaWYgKGFkZXYtPmZsYWdzICYg
QU1EX0lTX0FQVSAmJiBhZGV2LT5pbl9zMyAmJg0KPiA+ID4gLSAgICAgICAgICAgICAgICAgICAg
ICFhZGV2LT5zdXNwZW5kX2NvbXBsZXRlICYmDQo+ID4gPiAtICAgICAgICAgICAgICAgICAgICAg
c29sX3JlZykNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICBzb2xfcmVnKSB7DQo+ID4gPiAr
ICAgICAgICAgICAgIGFkZXYtPnN1c3BlbmRfY29tcGxldGUgPSBmYWxzZTsNCj4gPiA+ICAgICAg
ICAgICAgICAgcmV0dXJuIHRydWU7DQo+ID4gPiAtDQo+ID4gPiAtICAgICByZXR1cm4gZmFsc2U7
DQo+ID4gPiArICAgICB9IGVsc2Ugew0KPiA+ID4gKyAgICAgICAgICAgICBhZGV2LT5zdXNwZW5k
X2NvbXBsZXRlID0gdHJ1ZTsNCj4gPiA+ICsgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+
ID4gKyAgICAgfQ0KPiA+ID4gIH0NCj4gPiA+DQo+ID4gPiAgc3RhdGljIGludCBzb2MxNV9hc2lj
X3Jlc2V0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiA+ID4gLS0NCj4gPiA+IDIuMzQu
MQ0K
