Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928DAC2A072
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jan 2026 06:34:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CB0710E11F;
	Mon,  5 Jan 2026 06:34:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hCnaEglT";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013060.outbound.protection.outlook.com
 [40.93.196.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A54D10E11F
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Jan 2026 06:34:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIUTGVWhIM/pRJgll87yeFN90eZhMiTfdUhGFSOOVgcLUQm+s/TlJP4mSxrsaQHMaRrEmpOIdIR5KlrVEwUdbp/xyKWoA5eXaVD+KwGnhI1VxLEj9yp2e/S4A5yokVrJLX7t0NUaXBQ8r2MrPtyGAHglxjPw2hR1AbyOefJQMT1mAVzA5tXg/DHYE4iglHBCGrB2+ZWRopk2ZmuyK+CjZ8pAYuztEjGzyLpdi1Sj78AMLs9OO0ynUXj53cJx/1udWgutoNDSXVY+e5CFxZhlRA+RJrO6RmsLEeSB5DqEsPao95gKz+r0zuac3gDu+BjoN5Xz5d4N6zlvENU2szSrxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ReKjPZm2vQ/iYJ+98umHnqtExkNYYwM1NtFH5IlT6UA=;
 b=QHWUpcaxSNUZaeKNzQriVdhTHn6q3in4wMs3degKhhVot/ML0n5Rr5GoCfG376RK82qetJmIjUF5L/8g8piGRXMR1jJ4X8BjO2J0m2bY7itNAXWqz4+ZRjAraGSc/DZ1mf2/IbgQ9WTiUo5om1VLO18iYLwl7A6pdrvIhLctiPo2MQ+72nB09oZWgUC4Zh1Hnl5diA2h8X/TiyJ4vKHr2tY1Wzfm/v1KOeIa2E1aLBszBGB7eiCfofTFMvA1bugnNJZWboNKhlo1bxDtX0SNRMBT8O20FltRHcza8H2+5CJSvjBcC42MzAq5VcUxlcp8LkHZrfmekzdI+uOM4MsSEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ReKjPZm2vQ/iYJ+98umHnqtExkNYYwM1NtFH5IlT6UA=;
 b=hCnaEglTUMk3l0pcV86u2J+YzWNi6Avj8sPwxT+aeWTzWVkRotZuyW+7pdExzLBFmApvkAkir3pTUkCQw8BuNHp1RW+63MT0dMDQM+MdZA7Om4Wx+fXitlDKv74w9DznSo7DulZ502vqp0tGd9RaBK/lrTNJzf1Ju3X41RKN9MY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS7PR12MB5957.namprd12.prod.outlook.com (2603:10b6:8:7c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 06:33:59 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 06:33:59 +0000
Message-ID: <4c6c3eef-8cb2-4742-bfd2-9ca147bc9938@amd.com>
Date: Mon, 5 Jan 2026 12:03:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 09/10] drm/amdgpu: Add ioctl support for cwsr params
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com,
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Jesse.Zhang@amd.com
References: <20251203130436.745633-1-lijo.lazar@amd.com>
 <20251203130436.745633-10-lijo.lazar@amd.com>
 <CADnq5_MSYtLWFZXwhAkZ=X=WkjkserJEfF7DCgF8MsyDT3Q1sg@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_MSYtLWFZXwhAkZ=X=WkjkserJEfF7DCgF8MsyDT3Q1sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::11) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS7PR12MB5957:EE_
X-MS-Office365-Filtering-Correlation-Id: 10c2dc81-bc9c-4a4e-4d8a-08de4c246885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVJINmN0dlp0VlZpM082eTczZnlpUTBBM0pEZXUwQkFnYWlFck4wN1R5d21i?=
 =?utf-8?B?TVlUMkNBTVdWY3RacWhJWXdTckpGeGZlQ2l0S0hZVHZoc0RsWG1veXRJWnFB?=
 =?utf-8?B?eEVncHpmN281MXU3RG14OGhKSXc4NXBSY2lUR2t1bFNQdzlQK2g2UGZiUmlJ?=
 =?utf-8?B?cjNFS1JDYlFRS256QlEvdEd1bENOeE5JZHZScUp4dWdYRDJNZlAycGpPV015?=
 =?utf-8?B?aExza2FZMWpCNERRVEkvWU5LTW55bE51RW1zSmsyU2RlWUFNZ1h1Z09yZDFZ?=
 =?utf-8?B?WStETVAvKythT3MzSWpNWjBna0xVQWxZU1NNcFFoRmdWRTRreDB2MFl4Yk1Y?=
 =?utf-8?B?RWw2WE5NUnlXNnNNbFJFQ1lraEV3alJkYmMyUG8yc2NvcUFjUnB2QmhGUFph?=
 =?utf-8?B?dVBQN014OFcyT2xIQzNlYUVjcVhUTWV5K0pKMEFpV0hWOHphRVRzYmU4WDVa?=
 =?utf-8?B?NElpRktneWprVUkxaVQrUkxwcnp6T1o3UHI2UkVRYXFScmpVTnlPZlJPUklX?=
 =?utf-8?B?NmJRQUhIZmJnUHR1QTdBQmNtSDJ3azFiWEtUYnc4U2VSL003UTQ1ZlBTbUMy?=
 =?utf-8?B?cE53ekVNTmx6RmVYUzdXN05uZUZOVW5sK2tsNWx6WTMvZE5maUlOZUVEbTYz?=
 =?utf-8?B?eFRacWZCakp4Q2l4NlVuczhaelI0VkQ3N1ZGRm5nK0d4MnNUcFp4S3ZUWEM5?=
 =?utf-8?B?d0pML0M5cDVsbEk1TnFFL1NScVdobXRzeklCc3kvZkF5eFBrRTdlTUUwUGFq?=
 =?utf-8?B?Z215K0FvRUh3ZkFLRjlrTGFINmU1bDRRWU8xclo2eFdJbFpSemlCZndtVHdw?=
 =?utf-8?B?bkFLWUV4ZEtwNEcwSmJaeHcvUEV5R0tOTEtld292d1pNSUl6QTl5d2FrWk1N?=
 =?utf-8?B?ODFSa1VRWjN1dlJmbE1hejZWQld6SnZuZEhtMEhnMGp1dlU5NTF1bDIxWHIx?=
 =?utf-8?B?djdlY0M5UktDYUZxeEZaL2xIZkR0VGk4RnBLSDBlczN0dGJEbEpNR2RtdlY0?=
 =?utf-8?B?Vm1qaUJxTkRaSFFvc3Q5SnN3aUZMeWo2eGtwa2p3cE4wL0hkSUdMdkVNRmJ2?=
 =?utf-8?B?RmVzN2lnVCtiaDVuclRITDRDQnlUakt4K283TncrQmlyaWRhQjBNVXYxVDFy?=
 =?utf-8?B?bWRMbUpvU3AvUFhyVHZHWmVCc2dhNEc2UEFBSlNZbFdrc1ovNSttcHVHREZE?=
 =?utf-8?B?SmZiQ0RlUEcyaWM1d0QrWXJXNHloSzRvSjU1VW82d0ZoOXhFUUt5eGZDdytE?=
 =?utf-8?B?TVlhTXhiekxaM2xYa285SGljZXQ0L2Z3alp1VFl4SFFLWURIemVLelM5TFRH?=
 =?utf-8?B?SjRGNHNZNVVoQW5IZi9KSG5zaUVlRnd3QStDQmZiTEVZQldFa05wUk1raitZ?=
 =?utf-8?B?VXgrd0RxM3BncjhZYXY5S1M1akR3K0VENkt1SThhblMyL3Qwdy9BZnJETUZv?=
 =?utf-8?B?L3Q1U21mOVVaR1NVSGtsTk1ncnAyK216bmV4TnBCSlplUi85NkQya0lIeTJ4?=
 =?utf-8?B?ZjM0VWltSUFNUW13ZEtpdjBZWURsYk1mZE5tVDlSM0FzdSs3UTc2THpVT2pC?=
 =?utf-8?B?UHhLU3IyS3djZWxObDM3L0pIMjYzWVNza1FzKzVGeVd4M1BialExV0Z4N2l6?=
 =?utf-8?B?cjllL2k4ZXhWRy9VSWdLRUo2UzBtd2hRRFNuYW5kcDBpV2Z1WThOdjJ1T0xm?=
 =?utf-8?B?eEQ1RWh5bFJGQk0xOEpJRGhWL2p0MnpuME81T3pLK2RJMVhudXpBd3JyR3px?=
 =?utf-8?B?aGZYTVcwVGQxRGdkYmMzUUZrUkprTGhWTWNMWXV0YlFvcVNpMENNcENKeWQ2?=
 =?utf-8?B?a1FQTHJLM1NIMVlaOW9RNEg0NTRHYk5iT3lhaXBuTVJ4VUVKWXdjNENLR1l0?=
 =?utf-8?B?dHFGQWkyelBsK0VGSlFSQWllNVRPQjc0ZkZ0WU1GT2RUT2tWaUhkT1d3TnJ2?=
 =?utf-8?Q?WH3Gs5w0UspHuM6IwvW3tNMNqlow1qjL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1Q0SllzMERCQzFyMHNYL3hJalNVdXJhMGh2bXZMSE5OeXZDczdoVlI3NW5F?=
 =?utf-8?B?Kzh3UGNDbStHZno3Z2hnTzlGM0dNaEYyblA1ck9oelo5aUR0d2EvL3JQN2I0?=
 =?utf-8?B?c3B3QlZCVlc0b2FxMzlUM0xmMlJZbUNwaHB6TGsxSis0b1FKakg1Z3hGSlh0?=
 =?utf-8?B?RkNSZ3lWSzIvK2lvYlNzQ0NTcjFGMEcwbmFwaGc4WjVSbnRqRGE3RXRsTm9N?=
 =?utf-8?B?K2dCTElnWjVSQUg5OWFmYmhranJZbGx1UjEybDVCN3duZkRnSXhicEx6Znlv?=
 =?utf-8?B?dTBGa2FzdlZONkJUOG16bVY3OHltZXpXSDJuMDVJdFpjeHEwWEVTQzZTWk00?=
 =?utf-8?B?Z1hKMytWR21CZkdsWW4xazVpcXM4UldPQlVkWGxiUFFRVXlFcjBIWjgzamFG?=
 =?utf-8?B?dFpUQUkzTnlOWWxZZUQzaFZVNk15bE9peVlzc285MU5IMnFhQTV6RWFpTjFK?=
 =?utf-8?B?OFk1eFJ4dllwWUxPdlpSdit4SWRnS2Jhc3FidlFraVpGSENXS1B3QUEzOEds?=
 =?utf-8?B?RnorVmRzTCsxTDhwYzhoNDQxZmpWcmIyTE1UUm5hOVNjK1dubUlNbnFURXRW?=
 =?utf-8?B?dXFFek5xT3ZkNFhPMTBwTXI5Qi9lL0JDSDM1NkVZN2tJK0FXWm1lUUIzOTdn?=
 =?utf-8?B?WWZvdTNsS3VycUJjanJUdERkYVNqRHd5aFNKUVE5NFZDYWtKTTNSRjlQSzhM?=
 =?utf-8?B?cEFncENtWVNtRjBWcTMzWUdRTGlWSm5OWk8rQUdRQ1dTUDJWYVlnazAvUXdn?=
 =?utf-8?B?UzlPTm5vdmJZNGhLYkhLTCt0d2FGTXFORE13NEpHTCtTc2ZYRUVGQjZqeEdo?=
 =?utf-8?B?WGpvT0MrSjMvQVY5TjlIeDMzbUFlTFplcUVja2RQSUl6aXRrSzdaMmlSUkhm?=
 =?utf-8?B?RDlqUElZMTJTVnlXOXpWcGhJVE9tNEM0OFVlVTdmMzBIdWF0a1F5TGJqTFVG?=
 =?utf-8?B?T3c4ZmNETTdjT1A0OXNqV2lUMHFhV2piakVWWHRuQnYzOVEvMXMvSE1mVGwr?=
 =?utf-8?B?MWZwSkpyR0N3NXhkVGhndmFOZGxGS0tsWVZzZXJKNXljdjFpYVdpK0tMa1V2?=
 =?utf-8?B?K1hsYjgrT1UrRUNFOVZRU280QjcvVUVYS3htdVpPNnc5cEtLV255QnhNdlh6?=
 =?utf-8?B?NFU4cmJLa2hieTFIYk04RGhXNWE4YlhBSCtUY0lQYlU2Nnl3ZUxIN3I5VTQy?=
 =?utf-8?B?Q0sxVURKaVVHSzJMZHZibmhiN3lnSHdFNklETEFacnBsSEk3TTJncWRVUUdN?=
 =?utf-8?B?YVVDYTdlTVZKYXNzRkY3M01Ud2JDVmkrQkErQXFKQXUrbmdDRVZDY2RDUHo4?=
 =?utf-8?B?ZFNFdyt5VFk1SDNBTXVQbW1kQkxoMWhZcjNXL3dYNGkzS0JCaTlaanljWjd6?=
 =?utf-8?B?Wm9yT2Q1ZitwQ2xKR2paekdYbEVoR3cvNWRtaE1IL3pFOWdXS0NDL0srTU40?=
 =?utf-8?B?Q2RaalE2S3ZEeGJSMVpQMUxPcjZ4bXFiUjc1UHJsSmYyWFdpbzRTYW5VRjNk?=
 =?utf-8?B?YlQ4aWp6QU9YSytGeEVPM0NiNEtlN2NiZzVFWnJTblNzdGgwU1ovdXRnVXg2?=
 =?utf-8?B?S1lQRUM5aTNMUk5PS1kwL2JQSmMzdE9iVnJBalFGQ3dhcFJycE5UQ1hoL1Fn?=
 =?utf-8?B?U1I0ek9VWWt2R2lORGF1VGkyZWVDaDBnUmkxeEtsT0NwUFBXdnVzREJNTDFT?=
 =?utf-8?B?SEROZlVwUnVXTkNmcTlhNkdPaXNvSUZVNVk4YVAwWUIrK1ZwSzNMMXo5ZGJW?=
 =?utf-8?B?czV6Q2FLQitWL0ZNdXJqL1IybUdZS2lkM0ZpM2xQTEdOQytmQm85YWRkTTJ4?=
 =?utf-8?B?K0x0ZXZRUmJoeFozemYwV3Q3K2FrNFdWUmE3STU1RW5NeGZLQmVmOGxUdm1z?=
 =?utf-8?B?ZjB6VW5iLzRHckFMY3pKZXRWUGE2K3BpcTJ3NDl2RkRqRWJMWnROWG5WcDIw?=
 =?utf-8?B?d3p4NVZiRVlPek5HUktXK0c4MXNhU0hJV1FmVGxDdHBFZU94dmxHQmp5a2hz?=
 =?utf-8?B?OCtXQnlOUytIRVVqQTJQbHg4dWpPY0VKOGowUFJnblE1S3oycEY5TVVYb0Y2?=
 =?utf-8?B?SW81ay80bi9pdXpwVk1RR1R3b21tS093RGFPdk1MTDFDbThFKy8yTzZtcFBE?=
 =?utf-8?B?MmIxeWMzVnVsTFNReGRNbHlwSy9IazZUU1ZEbXh1aEUrZ0NCVk9rWDRtNEgv?=
 =?utf-8?B?RDJxaGpHdGRjMVd4NHBaNzkweDRtbXJQU0xBV01xVUZOWEl2UlAzM245MG4x?=
 =?utf-8?B?cDUwOWFZbkIwYWY2L01KdHFwYlcya096ajhFNTRoTGlqUlNIZ0FDVTZQSWNX?=
 =?utf-8?B?NXVCTHdzK0k2Q3czMzY3WnhlVnJwVWwvMjBWbDJFTUo2QVh2QXNFUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c2dc81-bc9c-4a4e-4d8a-08de4c246885
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 06:33:59.2854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yEGK+IgypGDLEkMh7rwv77TyUChwn3MvznETpPg/8ZHvVfDRnjt/4S/0yBhR6Gb5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5957
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



On 16-Dec-25 10:00 PM, Alex Deucher wrote:
> On Wed, Dec 3, 2025 at 8:05 AM Lijo Lazar <lijo.lazar@amd.com> wrote:
>>
>> Add cwsr parameters to userqueue ioctl. User should pass the GPU virtual
>> address for save/restore buffer, and size allocated. They are supported
>> only for user compute queues.
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 13 +++++++++----
>>   include/uapi/drm/amdgpu_drm.h              | 16 ++++++++++++++++
>>   2 files changed, 25 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> index 0ac87618a86a..8865a266d25a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> @@ -322,16 +322,21 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>>
>>                  if (amdgpu_cwsr_is_enabled(adev)) {
>>                          cwsr_params.ctx_save_area_address =
>> -                               userq_props->ctx_save_area_addr;
>> -                       cwsr_params.cwsr_sz = userq_props->ctx_save_area_size;
>> -                       cwsr_params.ctl_stack_sz = userq_props->ctl_stack_size;
>> -
>> +                               compute_mqd->ctx_save_area_addr;
>> +                       cwsr_params.cwsr_sz = compute_mqd->ctx_save_area_size;
>> +                       cwsr_params.ctl_stack_sz = compute_mqd->ctl_stack_size;
>>                          r = amdgpu_userq_input_cwsr_params_validate(
>>                                  queue, &cwsr_params);
>>                          if (r) {
>>                                  kfree(compute_mqd);
>>                                  goto free_mqd;
>>                          }
>> +                       userq_props->ctx_save_area_addr =
>> +                               compute_mqd->ctx_save_area_addr;
>> +                       userq_props->ctx_save_area_size =
>> +                               compute_mqd->ctx_save_area_size;
>> +                       userq_props->ctl_stack_size =
>> +                               compute_mqd->ctl_stack_size;
>>                  }
>>
>>                  kfree(compute_mqd);
>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>> index 2bb9daafb560..1a27e218d4ea 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -464,6 +464,22 @@ struct drm_amdgpu_userq_mqd_compute_gfx11 {
>>           * to get the size.
>>           */
>>          __u64   eop_va;
>> +       /**
>> +        * @ctx_save_area_addr: Virtual address of the GPU memory for save/restore buffer.
>> +        * This must be a from a separate GPU object, and use AMDGPU_INFO IOCTL
> 
> "be from"
> 
> Does it actually need to be a separate buffer?

Actually, I used the same terminology as used in eop va. I think it is 
better to keep a dedicated buffer allocated for lifetime control.

Thanks,
Lijo

> May also want a
> comment that this address covers both the ctx save area and the ctl
> stack.
> 
>> +        * to get the size.
>> +        */
>> +       __u64 ctx_save_area_addr;
> 
> ctx_save_area_va for consistently.
> 
> 
>> +       /**
>> +        * @ctx_save_area_size:  Total size allocated for save/restore buffer.
>> +        * Use AMDGPU_INFO IOCTL to get the size.
>> +        */
>> +       __u32 ctx_save_area_size;
>> +       /**
>> +        * @ctl_stack_size: Size of control stack region in the save/restore buffer.
>> +        * Use AMDGPU_INFO IOCTL to get the size.
>> +        */
> 
> Specify that these are in bytes.
> 
> Alex
> 
>> +       __u32 ctl_stack_size;
>>   };
>>
>>   /* userq signal/wait ioctl */
>> --
>> 2.49.0
>>

