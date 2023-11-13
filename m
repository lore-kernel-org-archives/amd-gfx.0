Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15EFC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Nov 2023 17:15:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69DA310E176;
	Mon, 13 Nov 2023 17:15:22 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::61e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0EFB10E176
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Nov 2023 17:15:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnakiDKitaJRr5ZPfYfRcCLW2pvP0FPik5m2Q/EHALonchJWZrXdqiT2Ani1/H03dhAqvMOpxKoTqOm1bbdFZ0SbZ2gDbE1g4ZacNf9qCTGFztS3IF1b3/QLt1Y13cBpJN3MPmJeWWXkSlu6/jChQlUjWjXQgIZ4cutiIhUQz+Fe3DZTGKiTfmslXhrbAitBJT41QPDC+f1XiyyoaDlnXS5mvHRXj+5avo+tHuX/8X41eMCJT6TOQRQ0/IeohvWVat8oYrohLQ64KYWqo4Nrx9uGMUnf71gHSj26pItnvcowYgA4nIliHe9+6ItlJVXFxT1f3OflPDayJC3OdmsnWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nsHtDwaI8FEQWjBvFLEpqgZqFcxps2nKf6Xx5qlQv0=;
 b=cXxxsBBDQM7u6eQCrMxBMtS6XLzeoHWNCAU/+LVd75L7JePK22dSf4y99AkSM13/dUPHD+/kib2WwN2A9ZbCJVhigBbOs5fTwVmhCcz5w2O4dbjyzcgAvqGOLUJ/c9Buv12grFy31W2cFCoy90LEajHvkFm9/BCok3uZMgJscPziLip8tbNHp03e/qXLyixG8ssEz5bSU4ttgRRn7cUdmWiORg9g/k0Qs8xcxGn9feZ8EQrW9Vdf5OmiY0in7eT8tKA6YEUOA6XsDS124I2rhJR/p2smf2geIcsdNZeO1GQszZjhHOPe95DG1A6FV+RBk0mfTMPh2YbI2Nah87/Htg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nsHtDwaI8FEQWjBvFLEpqgZqFcxps2nKf6Xx5qlQv0=;
 b=E3TB2Ld7RvHmpN8KwEzdbYnwPo3cRcyOdQ1li+Bm28/fDL4P61TUUWmvXaueba54byeYbFlMa2pn3iX2x8erouAVc4EkvH3ze9QCEaH2LePQ0Wq7XLJlQlLy8BGe33QDKyE1Dd6rzr1JaT2bWtcrzpRRYoVygFxRudWYveArWlw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by LV2PR12MB5941.namprd12.prod.outlook.com (2603:10b6:408:172::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Mon, 13 Nov
 2023 17:15:15 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04%6]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 17:15:15 +0000
Content-Type: multipart/alternative;
 boundary="------------rHjrmxvC9UH5XGcR3njHh32e"
Message-ID: <9c136abd-ab36-4cab-a8b3-99c70e87ee48@amd.com>
Date: Mon, 13 Nov 2023 12:15:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/24] drm/amdkfd: enable pc sampling stop
Content-Language: en-US
To: "Yat Sin, David" <David.YatSin@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-20-James.Zhu@amd.com>
 <DM6PR12MB50211E7128EDF3D5D6067B9295AEA@DM6PR12MB5021.namprd12.prod.outlook.com>
 <29c443f9-455b-481e-a2ae-f1315e447867@amd.com>
 <DM6PR12MB5021F2E9F4BE17C69FF1128E95B3A@DM6PR12MB5021.namprd12.prod.outlook.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <DM6PR12MB5021F2E9F4BE17C69FF1128E95B3A@DM6PR12MB5021.namprd12.prod.outlook.com>
X-ClientProxiedBy: YQBPR0101CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::47) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|LV2PR12MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: 63b00b5c-beef-4dc3-af69-08dbe46c1a29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pdcDl+9PGJOAtFcH4Uzo/46CqmdtpviNp1JqzItBye1F/xZey6cf/jb6v6O7QRyjiJcNUmy0bN+V2OlYV8DC7NrtsANyfzNq4Aj0dE3ywu+yAaaDSI2mdR6oe99Smz79SxeYXxyP2EonEN87MyLdG/NnMJ5LrSxm6DTU8aj9klTuM89EXdpWqIictNN7CXAUFDu8CibX3ySz/9rS4q2wq/+5/76THzdpmL9OW0kVRJj1tOyFrGxMUzSzAE4Ock4Ru4MgRlRLu7CQx6KBd6NBfrrNnvpDM2u2gDP9HjijOaMBAHyd9EH+KHnVa59Qg31uQdr/6PD30dSy4xJUM6D5PW8S0T5g7V1tVvhe6F07lbXp2J7p6YZ4zm0nAoaCES7h6xCW7L/8A20GsJ44mCAjbmnRyJsHfMNkn1WQjMu/LU61zJfs15026IGdaUyUWJ9mHedTsSHRXm0bJbbXZQ+d5IKhsbaDhL35vfx99RTj2fZE1jgRBByO0IRBN90R+5xTlytoqxfQBV+SoJuYj7X4MqwxZktnflP0DuyeeRJzQ2C3d/SoLjdLwzG7T5ECWd8c+pQcUcgv+eBraP9UBB5OxoEsPIftvZph1dXClhQG0qOzg5xwxwDG3yqI1LHRbJnWuF724asObLrxBjzkBN0p8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(396003)(366004)(136003)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(66899024)(36756003)(41300700001)(83380400001)(53546011)(6506007)(33964004)(36916002)(8936002)(4326008)(8676002)(6512007)(31696002)(2616005)(66946007)(110136005)(316002)(5660300002)(66556008)(54906003)(66476007)(38100700002)(31686004)(6486002)(4001150100001)(478600001)(26005)(6666004)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WG9JKzlyajlEdjdraTdIS21Ua3htTDBFQTRrRmNlOGJqNzdid2tjMkdzRCtu?=
 =?utf-8?B?RldJZTVvVXdNbWgrLzlmTFJMRnJSTndiN01HeUltdlBUSnlWTm93YTdnemxq?=
 =?utf-8?B?YlloZUJGT08vWUhTd0VUZzc4OVVpdVVPdEpXY25yaFF4a0VzcXhObFFLZ3hJ?=
 =?utf-8?B?ZThTZG56QkVrT3pZbzk4TFlUbTdjL0dqWkUzQlNSR0I2aTBCOWdxN3hDMVE0?=
 =?utf-8?B?N2Q5SE9VN1ZyK2hkSkZFRDZCVlNrY0ZTeXRhS0FhelRRcEY2UlBaQ1cyTi9O?=
 =?utf-8?B?bTU1ZXV5MnVJd2RNSFlOVHdZUktvS2lTTGplcFB3MDV0Q3BIWFpCRHY3bHpJ?=
 =?utf-8?B?ZUlHMlNIYUZjRFVJNUlDS2xFMk1hUElPalh0RDRDbmNtLy81N3hNZGJDMWxK?=
 =?utf-8?B?V1JBMy9DelpyL3RwNnRtb2NrM2hsckxIRUQxRnlyWEV1Q3NoUk1jbCtjU2xz?=
 =?utf-8?B?VU5uSUdiVG1MT2ExRWNnbGtLRXJ6NFJXOFJNaWJHbXNQOU9vK2YzZ0F5WVYz?=
 =?utf-8?B?bk1kYVZOQkwvTHVLakFTSFNLQkFXWkhjeC9PaElXc051ci9yUjFXc0E1THBR?=
 =?utf-8?B?TDc4V2g5NDhoUXU1OStmSTZCQVZYcE9Ddk9rcHZvR2hPOXNZWVV4TDVVL1pJ?=
 =?utf-8?B?YldVUERDNFlRV2RtKzcvZVFQR0VNWVhsaEFFcER3RE50dnY3TldpQkVWR3FR?=
 =?utf-8?B?N2N6ajFDbEl1V2Z3a2pyc2JtVzhMTzZyZmFqYVlPcXZMRVN2aGtMTzhWOWdZ?=
 =?utf-8?B?eGdRaDJjaCsxdnlYWjZPbTY0SXZ3VkVvN2dsbTdITkFmdWJjamdxNTBjYnNk?=
 =?utf-8?B?UllkN0NJQTNYbS8rSGRXTDV3UHBCWlNZRkxPK29oYjdGVndUclBRa3JLYnNn?=
 =?utf-8?B?UWUxcEgvSm9mQktUS0pPcWZsclZIcGdFQVBHTnhNbjA1aURZOFdZUnZzdEd4?=
 =?utf-8?B?bW82ME15L3hkYmFLdGhaZnBUTk9saWxCMmFmUnFpNGYzS1RTKy9GM2QxVVo3?=
 =?utf-8?B?TU9MTWZkMHJRNjMxMVY3OGVST3M5dnFVMERrNGJaSnRFTndKQTY2Y2NjUFhV?=
 =?utf-8?B?bGZLdlg4VnBuTDl1eTI5QUdPZTJDTEdPZUlORGUzcGdNMk5TOHFBUWg2VUhG?=
 =?utf-8?B?T3JUcUMvODdPZE56bFBmUnFZZ3VoY2dtS2dITHNhK1N2MGYxd1JpV3dJcjVh?=
 =?utf-8?B?WG82ZHRBamZsVUpPVFlIY2IzckhBNk4wNEV4dDN6Z1lrNmJ5TGFJbEpXVjg5?=
 =?utf-8?B?OVN0Qm5CM0Vzcy8vaUR6UnlrTEg3a0N0SlgrSXh5YkFraWtVRTJBdk1hWEFr?=
 =?utf-8?B?b0hqR1VlczM0bWpoYXlvZElWYUVtYTVSSWhYaWRoMHRQelk0TGN4SHJneitl?=
 =?utf-8?B?TjRMbms5anNkdjJWL1lwNUhYUmNVMGg1WmxnUjdqTEdtc0wxbzJnZlF6ZUhu?=
 =?utf-8?B?MGZYZThwWkNpcHRNcUF4VHVPOHJ6NE14Snp4NldWZTRyS0IwRUhKT1E2UGgw?=
 =?utf-8?B?N0lhQXhpdXdIMFRueFNGYlhqMXBxZU9sRWxTS2ZPcC9zQW1NeFl4TDU3QS90?=
 =?utf-8?B?YndQU1J6T0VUZHpyZ2t3OVNHWWd3TVdiamtFUUIxYmYyWlRhMkhOMHBJby96?=
 =?utf-8?B?Y084WHhIR25GaDF0U1ZLVUpTWnhIVGZ2eU9Id1lVNytJdG9rdE9xaEdwWitI?=
 =?utf-8?B?NXZLSm5LWmRIZktaU2x6YkpqaDgvWGxITzBtS0lhTjBkakVhSy9EWWQ3QWY5?=
 =?utf-8?B?RUJBR3N1NjdrVzVCcU9PSHVRcTk1Z0ErSldZUFA1c3VVTnVmSm5SUHBxM3pK?=
 =?utf-8?B?TjdzeFVrUzdsOWpKR1NPN1ZrbmdmTUg1YndabUI4QjMzaWJ5U1ltUXJYL1lR?=
 =?utf-8?B?L295TC9WaFR2dWxFSzNpQTVDZjUvNGtpb1gwZlZyRVFvbFI5WlZlV3U3T0Vz?=
 =?utf-8?B?eWI4RkFKT0NyOStYOHovcWpaQ2dRRFlRWHFIZFg3cnhKbUNsUHBiWjFJV0ZZ?=
 =?utf-8?B?bGhTelZqYzE4b2syamxqd0ZsTUhyeFIxSUVtSTFQOUt4VCtRRFNWeUxsejkx?=
 =?utf-8?B?eXFicVdjQWoyQkxLV1l6TXlDaXNGdVM5OGFvTFpwTS9LRWxlY3ZhV3FvTHdX?=
 =?utf-8?Q?ABcQdWg5nAzDh1Oarq9Ps3Akf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b00b5c-beef-4dc3-af69-08dbe46c1a29
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 17:15:15.1627 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eQ578IISIJ3Lgy//kmyPf+aCkSFmenaQQISfM/uzn/56s1JeZdU5BqyO+iNk270d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5941
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Greathouse,
 Joseph" <Joseph.Greathouse@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------rHjrmxvC9UH5XGcR3njHh32e
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2023-11-13 12:04, Yat Sin, David wrote:
>
> [AMD Official Use Only - General]
>
>
> *From:* Zhu, James <James.Zhu@amd.com>
> *Sent:* Monday, November 13, 2023 10:20 AM
> *To:* Yat Sin, David <David.YatSin@amd.com>; Zhu, James 
> <James.Zhu@amd.com>; amd-gfx@lists.freedesktop.org
> *Cc:* Kuehling, Felix <Felix.Kuehling@amd.com>; Greathouse, Joseph 
> <Joseph.Greathouse@amd.com>
> *Subject:* Re: [PATCH 19/24] drm/amdkfd: enable pc sampling stop
>
> On 2023-11-10 14:07, Yat Sin, David wrote:
>
>     [AMD Official Use Only - General]
>
>         -----Original Message-----
>
>         From: Zhu, James<James.Zhu@amd.com>  <mailto:James.Zhu@amd.com>
>
>         Sent: Friday, November 3, 2023 9:12 AM
>
>         To:amd-gfx@lists.freedesktop.org
>
>         Cc: Kuehling, Felix<Felix.Kuehling@amd.com>  <mailto:Felix.Kuehling@amd.com>; Greathouse, Joseph
>
>         <Joseph.Greathouse@amd.com>  <mailto:Joseph.Greathouse@amd.com>; Yat Sin, David<David.YatSin@amd.com>  <mailto:David.YatSin@amd.com>; Zhu,
>
>         James<James.Zhu@amd.com>  <mailto:James.Zhu@amd.com>
>
>         Subject: [PATCH 19/24] drm/amdkfd: enable pc sampling stop
>
>         Enable pc sampling stop.
>
>         Signed-off-by: James Zhu<James.Zhu@amd.com>  <mailto:James.Zhu@amd.com>
>
>         ---
>
>           drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 28 +++++++++++++++++--
>
>         -
>
>           drivers/gpu/drm/amd/amdkfd/kfd_priv.h        |  2 ++
>
>           2 files changed, 27 insertions(+), 3 deletions(-)
>
>         diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>
>         b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>
>         index 33d003ca0093..2c4ac5b4cc4b 100644
>
>         --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>
>         +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>
>         @@ -108,10 +108,32 @@ static int kfd_pc_sample_start(struct
>
>         kfd_process_device *pdd,
>
>                return 0;
>
>           }
>
>         -static int kfd_pc_sample_stop(struct kfd_process_device *pdd)
>
>         +static int kfd_pc_sample_stop(struct kfd_process_device *pdd,
>
>         +                                     struct pc_sampling_entry *pcs_entry)
>
>           {
>
>         -     return -EINVAL;
>
>         +     bool pc_sampling_stop = false;
>
>         +
>
>         +     pcs_entry->enabled = false;
>
>         +     mutex_lock(&pdd->dev->pcs_data.mutex);
>
>     For the START/STOP/DESTROY ioctls, I think we can hold pdd->dev->pcs_data.mutex through the whole IOCTL. Then we would not have to deal with the intermediate states where the START/STOP/DESTROY are happening at the same time.
>
> [JZ] pdd->dev->pcs_data.mutex is per device, not per process. In the 
> future, also it will share protection within different pc sampling 
> methods on the same devices. So I don't think a bigger lock here is 
> good idea.
> [David] I think the CREATE/START/STOP/DESTROY actions are not time 
> critical. So if two processes are using the same GPU, it is ok for 
> amdgpu to block the 2^nd process until amdgpu has fully completed the 
> request from the 1^st process. I think we are making the code more 
> complex for a use-case that would be very rare.
>
[JZ] IIRC, the init RFC version used bigger lock, and is questioned as 
an inefficient way,
>
>
>         +     pdd->dev->pcs_data.hosttrap_entry.base.active_count--;
>
>         +     if (!pdd->dev->pcs_data.hosttrap_entry.base.active_count) {
>
>         +             WRITE_ONCE(pdd->dev-
>
>             pcs_data.hosttrap_entry.base.stop_enable, true);
>
>         +             pc_sampling_stop = true;
>
>         +     }
>
>         +     mutex_unlock(&pdd->dev->pcs_data.mutex);
>
>         +     if (pc_sampling_stop) {
>
>         +             kfd_process_set_trap_pc_sampling_flag(&pdd->qpd,
>
>         +                     pdd->dev-
>
>             pcs_data.hosttrap_entry.base.pc_sample_info.method,
>
>         +false);
>
>         +
>
>         +             mutex_lock(&pdd->dev->pcs_data.mutex);
>
>         +             pdd->dev->pcs_data.hosttrap_entry.base.target_simd = 0;
>
>         +             pdd->dev->pcs_data.hosttrap_entry.base.target_wave_slot = 0;
>
>         +             WRITE_ONCE(pdd->dev-
>
>             pcs_data.hosttrap_entry.base.stop_enable, false);
>
>         +             mutex_unlock(&pdd->dev->pcs_data.mutex);
>
>         +     }
>
>         +
>
>         +     return 0;
>
>           }
>
>           static int kfd_pc_sample_create(struct kfd_process_device *pdd, @@ -251,7
>
>         +273,7 @@ int kfd_pc_sample(struct kfd_process_device *pdd,
>
>                        if (!pcs_entry->enabled)
>
>                                return -EALREADY;
>
>                        else
>
>         -                     return kfd_pc_sample_stop(pdd);
>
>         +                     return kfd_pc_sample_stop(pdd, pcs_entry);
>
>                }
>
>                return -EINVAL;
>
>         diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>
>         b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>
>         index 613910e0d440..badaa4d68cc4 100644
>
>         --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>
>         +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>
>         @@ -259,6 +259,8 @@ struct kfd_dev;
>
>           struct kfd_dev_pc_sampling_data {
>
>                uint32_t use_count;         /* Num of PC sampling sessions */
>
>                uint32_t active_count;      /* Num of active sessions */
>
>         +     uint32_t target_simd;       /* target simd for trap */
>
>         +     uint32_t target_wave_slot;  /* target wave slot for trap */
>
>                bool stop_enable;           /* pc sampling stop in process */
>
>                struct idr pc_sampling_idr;
>
>                struct kfd_pc_sample_info pc_sample_info;
>
>         --
>
>         2.25.1
>
--------------rHjrmxvC9UH5XGcR3njHh32e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2023-11-13 12:04, Yat Sin, David
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:DM6PR12MB5021F2E9F4BE17C69FF1128E95B3A@DM6PR12MB5021.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered medium)">
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	font-size:10.0pt;
	font-family:"Courier New";}span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;}span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <p style="font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        [AMD Official Use Only - General]<br>
      </p>
      <br>
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <div style="border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in 4.0pt">
            <div>
              <div style="border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in 0in 0in">
                <p class="MsoNormal"><b>From:</b> Zhu, James
                  <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a> <br>
                  <b>Sent:</b> Monday, November 13, 2023 10:20 AM<br>
                  <b>To:</b> Yat Sin, David
                  <a class="moz-txt-link-rfc2396E" href="mailto:David.YatSin@amd.com">&lt;David.YatSin@amd.com&gt;</a>; Zhu, James
                  <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>;
                  <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                  <b>Cc:</b> Kuehling, Felix
                  <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>; Greathouse, Joseph
                  <a class="moz-txt-link-rfc2396E" href="mailto:Joseph.Greathouse@amd.com">&lt;Joseph.Greathouse@amd.com&gt;</a><br>
                  <b>Subject:</b> Re: [PATCH 19/24] drm/amdkfd: enable
                  pc sampling stop<o:p></o:p></p>
              </div>
            </div>
            <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            <p><o:p>&nbsp;</o:p></p>
            <div>
              <p class="MsoNormal">On 2023-11-10 14:07, Yat Sin, David
                wrote:<o:p></o:p></p>
            </div>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <pre>[AMD Official Use Only - General]<o:p></o:p></pre>
              <pre><o:p>&nbsp;</o:p></pre>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <pre>-----Original Message-----<o:p></o:p></pre>
                <pre>From: Zhu, James <a href="mailto:James.Zhu@amd.com" moz-do-not-send="true">&lt;James.Zhu@amd.com&gt;</a><o:p></o:p></pre>
                <pre>Sent: Friday, November 3, 2023 9:12 AM<o:p></o:p></pre>
                <pre>To: <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a><o:p></o:p></pre>
                <pre>Cc: Kuehling, Felix <a href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">&lt;Felix.Kuehling@amd.com&gt;</a>; Greathouse, Joseph<o:p></o:p></pre>
                <pre><a href="mailto:Joseph.Greathouse@amd.com" moz-do-not-send="true">&lt;Joseph.Greathouse@amd.com&gt;</a>; Yat Sin, David <a href="mailto:David.YatSin@amd.com" moz-do-not-send="true">&lt;David.YatSin@amd.com&gt;</a>; Zhu,<o:p></o:p></pre>
                <pre>James <a href="mailto:James.Zhu@amd.com" moz-do-not-send="true">&lt;James.Zhu@amd.com&gt;</a><o:p></o:p></pre>
                <pre>Subject: [PATCH 19/24] drm/amdkfd: enable pc sampling stop<o:p></o:p></pre>
                <pre><o:p>&nbsp;</o:p></pre>
                <pre>Enable pc sampling stop.<o:p></o:p></pre>
                <pre><o:p>&nbsp;</o:p></pre>
                <pre>Signed-off-by: James Zhu <a href="mailto:James.Zhu@amd.com" moz-do-not-send="true">&lt;James.Zhu@amd.com&gt;</a><o:p></o:p></pre>
                <pre>---<o:p></o:p></pre>
                <pre> drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 28 +++++++++++++++++--<o:p></o:p></pre>
                <pre>-<o:p></o:p></pre>
                <pre> drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 ++<o:p></o:p></pre>
                <pre> 2 files changed, 27 insertions(+), 3 deletions(-)<o:p></o:p></pre>
                <pre><o:p>&nbsp;</o:p></pre>
                <pre>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c<o:p></o:p></pre>
                <pre>b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c<o:p></o:p></pre>
                <pre>index 33d003ca0093..2c4ac5b4cc4b 100644<o:p></o:p></pre>
                <pre>--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c<o:p></o:p></pre>
                <pre>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c<o:p></o:p></pre>
                <pre>@@ -108,10 +108,32 @@ static int kfd_pc_sample_start(struct<o:p></o:p></pre>
                <pre>kfd_process_device *pdd,<o:p></o:p></pre>
                <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></pre>
                <pre> }<o:p></o:p></pre>
                <pre><o:p>&nbsp;</o:p></pre>
                <pre>-static int kfd_pc_sample_stop(struct kfd_process_device *pdd)<o:p></o:p></pre>
                <pre>+static int kfd_pc_sample_stop(struct kfd_process_device *pdd,<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pc_sampling_entry *pcs_entry)<o:p></o:p></pre>
                <pre> {<o:p></o:p></pre>
                <pre>-&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp; bool pc_sampling_stop = false;<o:p></o:p></pre>
                <pre>+<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp; pcs_entry-&gt;enabled = false;<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;pdd-&gt;dev-&gt;pcs_data.mutex);<o:p></o:p></pre>
              </blockquote>
              <pre>For the START/STOP/DESTROY ioctls, I think we can hold pdd-&gt;dev-&gt;pcs_data.mutex through the whole IOCTL. Then we would not have to deal with the intermediate states where the START/STOP/DESTROY are happening at the same time.<o:p></o:p></pre>
            </blockquote>
            <p class="MsoNormal" style="margin-left:5.25pt">[JZ]
              pdd-&gt;dev-&gt;pcs_data.mutex is per device, not per
              process. In the future, also it will share protection
              within different pc sampling methods on the same devices.
              So I don't think a bigger lock here is good idea.<br>
              [David] I think the CREATE/START/STOP/DESTROY actions are
              not time critical. So if two processes are using the same
              GPU, it is ok for amdgpu to block the 2<sup>nd</sup>
              process until amdgpu has fully completed the request from
              the 1<sup>st</sup> process. I think we are making the code
              more complex for a use-case that would be very rare.<br>
            </p>
          </div>
        </div>
      </div>
    </blockquote>
    [JZ] IIRC, the init RFC version used bigger lock, and is questioned
    as an inefficient way,<br>
    <blockquote type="cite" cite="mid:DM6PR12MB5021F2E9F4BE17C69FF1128E95B3A@DM6PR12MB5021.namprd12.prod.outlook.com">
      <div>
        <div class="WordSection1">
          <div style="border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in 4.0pt">
            <p class="MsoNormal" style="margin-left:5.25pt">
              <br>
              <o:p></o:p></p>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;dev-&gt;pcs_data.hosttrap_entry.base.active_count--;<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp; if (!pdd-&gt;dev-&gt;pcs_data.hosttrap_entry.base.active_count) {<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE_ONCE(pdd-&gt;dev-<o:p></o:p></pre>
                <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                  <pre>pcs_data.hosttrap_entry.base.stop_enable, true);<o:p></o:p></pre>
                </blockquote>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pc_sampling_stop = true;<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;pdd-&gt;dev-&gt;pcs_data.mutex);<o:p></o:p></pre>
                <pre><o:p>&nbsp;</o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp; if (pc_sampling_stop) {<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_process_set_trap_pc_sampling_flag(&amp;pdd-&gt;qpd,<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;dev-<o:p></o:p></pre>
                <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                  <pre>pcs_data.hosttrap_entry.base.pc_sample_info.method,<o:p></o:p></pre>
                </blockquote>
                <pre>+false);<o:p></o:p></pre>
                <pre>+<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;pdd-&gt;dev-&gt;pcs_data.mutex);<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;dev-&gt;pcs_data.hosttrap_entry.base.target_simd = 0;<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;dev-&gt;pcs_data.hosttrap_entry.base.target_wave_slot = 0;<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE_ONCE(pdd-&gt;dev-<o:p></o:p></pre>
                <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                  <pre>pcs_data.hosttrap_entry.base.stop_enable, false);<o:p></o:p></pre>
                </blockquote>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;pdd-&gt;dev-&gt;pcs_data.mutex);<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
                <pre>+<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></pre>
                <pre> }<o:p></o:p></pre>
                <pre><o:p>&nbsp;</o:p></pre>
                <pre> static int kfd_pc_sample_create(struct kfd_process_device *pdd, @@ -251,7<o:p></o:p></pre>
                <pre>+273,7 @@ int kfd_pc_sample(struct kfd_process_device *pdd,<o:p></o:p></pre>
                <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pcs_entry-&gt;enabled)<o:p></o:p></pre>
                <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EALREADY;<o:p></o:p></pre>
                <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<o:p></o:p></pre>
                <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return kfd_pc_sample_stop(pdd);<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return kfd_pc_sample_stop(pdd, pcs_entry);<o:p></o:p></pre>
                <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
                <pre><o:p>&nbsp;</o:p></pre>
                <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<o:p></o:p></pre>
                <pre>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<o:p></o:p></pre>
                <pre>b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<o:p></o:p></pre>
                <pre>index 613910e0d440..badaa4d68cc4 100644<o:p></o:p></pre>
                <pre>--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<o:p></o:p></pre>
                <pre>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<o:p></o:p></pre>
                <pre>@@ -259,6 +259,8 @@ struct kfd_dev;<o:p></o:p></pre>
                <pre> struct kfd_dev_pc_sampling_data {<o:p></o:p></pre>
                <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t use_count;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Num of PC sampling sessions */<o:p></o:p></pre>
                <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t active_count;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Num of active sessions */<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp; uint32_t target_simd;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* target simd for trap */<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp; uint32_t target_wave_slot;&nbsp; /* target wave slot for trap */<o:p></o:p></pre>
                <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool stop_enable;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* pc sampling stop in process */<o:p></o:p></pre>
                <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct idr pc_sampling_idr;<o:p></o:p></pre>
                <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_pc_sample_info pc_sample_info;<o:p></o:p></pre>
                <pre>--<o:p></o:p></pre>
                <pre>2.25.1<o:p></o:p></pre>
              </blockquote>
              <pre><o:p>&nbsp;</o:p></pre>
            </blockquote>
          </div>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------rHjrmxvC9UH5XGcR3njHh32e--
