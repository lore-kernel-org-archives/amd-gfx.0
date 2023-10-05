Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD33E9370C
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Oct 2023 13:45:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C05EB10E16D;
	Thu,  5 Oct 2023 13:45:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::61d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 430E010E16D
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Oct 2023 13:45:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHqGUUpUk33iJpXcOONYnpZDzZU5xHfPLu0DakOwp+7/Ri++gtoJS0hJlmncQafFtr32qBg4dzf87IMN7qWbVfZZakBhT6Sq1oWZ0dLyQ/1laqJnwvKij3EaTiu+zm6hoiNIBkDAsN3W7BHr5gYUVeH6yFNZ1gaZfgzWsJuPxaoF+Vsaj4WEXhMpQVETZCGtoJO5zoGq9VSaAjcm+cxT1xwxsJ3grhODynBNE18Ti3+VRUsawmrXwskn2CIytpHPe1CAkp1KhAiqNnghT1IIAjLzhOcysmhLiR2EQlCu8Rj+6bRgsrNxApGqfbnDY4Cu3STwPvUM/DrE8lZks/wjdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/ckg472THnSUPIw274rTyQzAladwuoCGxB9Cuwd2ks=;
 b=S5JdLa5JVdjjX48lUqr0ZaYBboKnE0dK75nvbYprsUlPa7NCFUdLhhCEWD/vcI0Jr4NmcojmQinIk/XlTqFv30zkSF97ufxm+RNxhM2+fU/5LqniXNsItUU1MlUJereoCTwZR4JtMcU2aFoK18WopSzQd9v4Ado90YpnoCb2+htY787XE3QsUriR1YULIzkisAM3qiKraGfLXQz5rQANV//gEMH/aNg3qldxMpozLaaLIlOo/saYT+iS35sxlkKeKpuJ1tLY3WgAgH3E1SOapH1UKvCIo5Mf4qS8n/Y5/K+BSOBf6V3j+GILmtNrQShbe4or/qbWHDxdxkP3mUhMoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/ckg472THnSUPIw274rTyQzAladwuoCGxB9Cuwd2ks=;
 b=SqM/xO1+aiEjwa9QBdw/SCQLubGZ8yxyP/sZoDf+rYlgwpERg4sjfENrC9s5xK/Qb1DcpvBBGvK6ZO9MK3MU8LQducRhRhJMkAN93u3AV+fOmEvz5oVurGHeFj++0utmXa8aY2/4BvrS3IzgFUox4Ut5G8bx6HxeymGjZqmdzpw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Thu, 5 Oct
 2023 13:45:18 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 13:45:18 +0000
Message-ID: <78abc334-44ed-4632-8796-6bbe9c432501@amd.com>
Date: Thu, 5 Oct 2023 08:45:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Fix UBSAN array-index-out-of-bounds for Polaris
 and Tonga
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20231004204644.182618-1-mario.limonciello@amd.com>
 <CADnq5_ON-+ZE_Op_16ihsva-EOBtb91GZO+fepox42SS0nT1ZQ@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_ON-+ZE_Op_16ihsva-EOBtb91GZO+fepox42SS0nT1ZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR11CA0030.namprd11.prod.outlook.com
 (2603:10b6:806:6e::35) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d066352-f14d-4700-e6fa-08dbc5a94fb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 42varvEwmU5igXf3O8lhg/eb65w7vml8KE4dDGSTUdGoKHOJ9TvE0UMRvXJJ3x4GneTmrEn5Nu9XyY1UNcMWgqKD4dENFtTgPUxsce5sIQs9zwc1cr65UtIcNRk4dD5TX6NGDIWKBO4jdlY8ARGxhDNrYtnflVh8hNDxpw/fE3DIUfHJ8aInmkbg0F4Llgz5OAsQogWIjgRh3MhDQJClnZvh2g4oL+dbekKI3jTFgdxBk6tfJNA7+NO3FJe3fSqU+NEYi9r3TI7/SqqbmuRFy3/Dsd7ow/D0l62dBxB4kuNF/v1OU7MAfLBZL5SYQxoV05xnIpP754tvAlWpBRlP6p0T6r9uneyAdeHmeY+cfy61ckfEbhp8PFrJLA9EYEgyA83yk66Bz0tXkDJkqOn4PGHrTQBfkaVC6gYRsHgy84rpDiPTW3n2anRACf+HcS1RKIvONhJsHkzWp1FUc3MnE19ubmluYuf1ETun9lvuBVZcEMtKHDNTry2olfjg/Z+tjv0OfNMv6t5asbg4+sDpcR+Jx/+RDQd7eqd5fOTwidptCTGpWZYtFb1UkY34D4G1mcqqtSkoLf0M1TTMlPKsYIIr9cxAyCUq7u69M5Rc2M3bQzJQJYCuFjfv2TrGSOkogFBZbVmuNP3SGrPCIvfzkqFMQ0fNKCacbIYS+kdQCBMOJ6JDHpH0OhzVSwC8ndIi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66476007)(31686004)(53546011)(6486002)(6512007)(6506007)(478600001)(2616005)(31696002)(36756003)(38100700002)(86362001)(26005)(2906002)(41300700001)(966005)(83380400001)(8676002)(316002)(8936002)(66946007)(5660300002)(6916009)(4326008)(66556008)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXo5M3FvaXhFTHB6d1lXME1PdlJ6cTFSaUU3V0hSYjdOdzJra3lQSTFhSjBG?=
 =?utf-8?B?dGEwQnFVbzE0YzIzUERCdWhWc3VMWWl1MEZVaVdaQzh2bW1acHl4cDBIbm5K?=
 =?utf-8?B?a1dmY1cwWmluNFh0cGFaMkh6S3BkZEVIQm9kNDFkdTBJd2Jpd2dlZVJ6NUVr?=
 =?utf-8?B?S0ZnNk1LRE9RVmx3eU40M085eXRyckY0MTlSWmZ0YWNJak9xMjNFeXpGM2Fh?=
 =?utf-8?B?V0NzVUNUNUZYYkZ3dTFYa08xUmoxcWt1K1lOV3JmU2tNT1BYL3lzRjhTaFI0?=
 =?utf-8?B?am82T3ZscE44UDFadks0bVYwemlTTVBGZm8yL3UyOWNSZ1dLVGc2SWZaMDM4?=
 =?utf-8?B?bkRFNnRlRk5NMHZtSjk3cWVhWFkxdWpaVi9IcFhZMWZHMGVIdGR1RXJnWXF4?=
 =?utf-8?B?L1N2YVR0cXBNRGlhN3d0cy9LYjlEM1U1MUd2VmhiUDZsMXRiYVViK2hLMDNC?=
 =?utf-8?B?WXRGUVdvZUk0eHY3a0pvL0hodWw0ZFNWU2hEczVObVdmMi92NEdYVURGNHlx?=
 =?utf-8?B?MVcyS0VGVnVXRTR6SEJXTlpTR25oMHFFaGN1bWI5UmlIYXZnbjJqdHdsRHll?=
 =?utf-8?B?VXdRb2cxQWZRdis0ZjgwakZGSFppSkpKYktLdURTdnBEN3o2am5ydDV3bnds?=
 =?utf-8?B?d0hOKys5c1V0SDEySlRZNk0vSUNMNTFRVWtoRGNFS0dFQUw3Rk14SHRvWk5X?=
 =?utf-8?B?ZGh6U1dwaUJxVnBoN2Y0VDdoWm5EQjRING9ZYW1xUFBFNmt6OGFJZ1Q4ajZp?=
 =?utf-8?B?ZGJoTWZ0SlRZcjY1VUUyeGFLYWZPdkh0VXRuM1FVOGhjQkRhRVdlOFJlbDkr?=
 =?utf-8?B?NVpxOFFSV21WZFBseTBNKytwaVVYbnlaYm11TWwwQlZObGtHTW5Hbjl1QStl?=
 =?utf-8?B?WDZQR3VOMzVZallPUHI2Q1I4MXlWWG92ODk4NFpEdE1TOTJndUtObEJDODd2?=
 =?utf-8?B?Ny9CMXdHSGFJUUJCYjhmZmFpYStoaXNtQkFQSVBhKytqa083U0ljbmtWeWM2?=
 =?utf-8?B?VE90ZGZXUjRLQVArUHVFd2JHNU4vdXJka3dleU9Cc00vNEdQMjNkUW1GejdN?=
 =?utf-8?B?T0ZudVY4NFo3eEdrTnE0UkJYQ3YyN1VDQXVQMm1xQy94aXNxRERRa2VrOG0y?=
 =?utf-8?B?NDVWT3IzNEQ0Uzk4S3F4RkdmRUs1dnF3djBlaW8zVWc4Vk9BWmdqd1NQWmlu?=
 =?utf-8?B?UW94RERpL0FCTndOK2JuZExPWFRoMENGanEvY29mQStvaE1USURuWUpiTUc3?=
 =?utf-8?B?Mnc4ZW5DTDZxSERFd2J5UldFN3ZLY3ZYbXowMzJGNHRPZUJCenJRbnpxbDdn?=
 =?utf-8?B?N0tDWmN6Z3BlYVUrYnNXaFdueWZnM0VSL2NMQzdZYytiK28xSzh6cXBiNGJh?=
 =?utf-8?B?UGlHeXdZb3B6YmdZRmRoQU9BODlOUHVyU0NFODhHbmdNeTdqMHhsY2NOa01Z?=
 =?utf-8?B?OS9ZcEhRMEdwS1I4a3JTaUd5eGNOVWVpbEMxL1NpTWdtanQ1TVBwdGtYcS9E?=
 =?utf-8?B?d2JrT3RmaEphNi9IQXJtTHRydk9WR3AweXY3MWwzdGJXK2EybW5Za2ltVVpW?=
 =?utf-8?B?U3NqMTBsQm4ySE5sV3l6NGphT29Gc2ZyazFOdGVXY3J3Ukd4alhNY3NCSjI3?=
 =?utf-8?B?V2VkMytXd3laaUFPVnRYWFlJMTcxaWN2TjRxb2hmYjc0S1pweml6TlNhSGZo?=
 =?utf-8?B?T3NEZmZFV01hUnREdlJVTHlFWnVVYkJDdzUwVjZ2WmdQd0ZUS3NrbVBVV1VF?=
 =?utf-8?B?dE9WbHo4V3VIVDZJWnRpRmh3ODBIRm1KZ3NIRm0xb0RZLzFDRVkwSmhjeExL?=
 =?utf-8?B?VnhtOW95cnY5SmFUYnhFQkNJdFJwcXIyV2FFUFhHaTdWOE1oRWhHVE55RkZU?=
 =?utf-8?B?L2JETktzVnRJTHR4YitEU0k4eU1FdmxhdU1XbTJpbEgrdmVLWVFKd0h4MWcv?=
 =?utf-8?B?dG1EQSswRFBMRnRYVlVaSXV2VUxJb3dsYXNzTjRseVZqVDJaelZDS3dlaGVF?=
 =?utf-8?B?VS9tSEJzT25jdTNnSXhibmRSSHlzYWg0Z2NIeXUrR2lnRlR5VTVLMkhveGpO?=
 =?utf-8?B?RVFSSG1zdU56WHRodkhMTjV1WGcrU1NwUDRzcDFxd05FVk5TSGxXa21oaWlx?=
 =?utf-8?Q?N/U0lBVd+/Ipt7hmaf3yq98eu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d066352-f14d-4700-e6fa-08dbc5a94fb7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 13:45:18.2210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CNvQDGytmRG6aVOZO/35gYw/A59j3GJsgGMQvtetZUBs4wL40E8OMnBjuCJl7O24Wots+Fy/m58OxFFQJgd5nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7736
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 10/4/2023 16:50, Alex Deucher wrote:
> On Wed, Oct 4, 2023 at 5:42 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> For pptable structs that use flexible array sizes, use flexible arrays.
>>
>> Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2036742
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Thanks, can you also review the similar (but different) series of the 
other variable arrays?

https://lore.kernel.org/amd-gfx/20231004202253.182540-1-mario.limonciello@amd.com/T/#t

> 
>> ---
>>  From this bug report there are more to fix
>>   .../gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h    | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
>> index 57bca1e81d3a..9fcad69a9f34 100644
>> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
>> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
>> @@ -164,7 +164,7 @@ typedef struct _ATOM_Tonga_State {
>>   typedef struct _ATOM_Tonga_State_Array {
>>          UCHAR ucRevId;
>>          UCHAR ucNumEntries;             /* Number of entries. */
>> -       ATOM_Tonga_State entries[1];    /* Dynamically allocate entries. */
>> +       ATOM_Tonga_State entries[];     /* Dynamically allocate entries. */
>>   } ATOM_Tonga_State_Array;
>>
>>   typedef struct _ATOM_Tonga_MCLK_Dependency_Record {
>> @@ -210,7 +210,7 @@ typedef struct _ATOM_Polaris_SCLK_Dependency_Record {
>>   typedef struct _ATOM_Polaris_SCLK_Dependency_Table {
>>          UCHAR ucRevId;
>>          UCHAR ucNumEntries;                                                     /* Number of entries. */
>> -       ATOM_Polaris_SCLK_Dependency_Record entries[1];                          /* Dynamically allocate entries. */
>> +       ATOM_Polaris_SCLK_Dependency_Record entries[];                           /* Dynamically allocate entries. */
>>   } ATOM_Polaris_SCLK_Dependency_Table;
>>
>>   typedef struct _ATOM_Tonga_PCIE_Record {
>> @@ -222,7 +222,7 @@ typedef struct _ATOM_Tonga_PCIE_Record {
>>   typedef struct _ATOM_Tonga_PCIE_Table {
>>          UCHAR ucRevId;
>>          UCHAR ucNumEntries;                                                                             /* Number of entries. */
>> -       ATOM_Tonga_PCIE_Record entries[1];                                                      /* Dynamically allocate entries. */
>> +       ATOM_Tonga_PCIE_Record entries[];                                                       /* Dynamically allocate entries. */
>>   } ATOM_Tonga_PCIE_Table;
>>
>>   typedef struct _ATOM_Polaris10_PCIE_Record {
>> @@ -235,7 +235,7 @@ typedef struct _ATOM_Polaris10_PCIE_Record {
>>   typedef struct _ATOM_Polaris10_PCIE_Table {
>>          UCHAR ucRevId;
>>          UCHAR ucNumEntries;                                         /* Number of entries. */
>> -       ATOM_Polaris10_PCIE_Record entries[1];                      /* Dynamically allocate entries. */
>> +       ATOM_Polaris10_PCIE_Record entries[];                      /* Dynamically allocate entries. */
>>   } ATOM_Polaris10_PCIE_Table;
>>
>>
>> @@ -252,7 +252,7 @@ typedef struct _ATOM_Tonga_MM_Dependency_Record {
>>   typedef struct _ATOM_Tonga_MM_Dependency_Table {
>>          UCHAR ucRevId;
>>          UCHAR ucNumEntries;                                                                             /* Number of entries. */
>> -       ATOM_Tonga_MM_Dependency_Record entries[1];                        /* Dynamically allocate entries. */
>> +       ATOM_Tonga_MM_Dependency_Record entries[];                         /* Dynamically allocate entries. */
>>   } ATOM_Tonga_MM_Dependency_Table;
>>
>>   typedef struct _ATOM_Tonga_Voltage_Lookup_Record {
>> @@ -265,7 +265,7 @@ typedef struct _ATOM_Tonga_Voltage_Lookup_Record {
>>   typedef struct _ATOM_Tonga_Voltage_Lookup_Table {
>>          UCHAR ucRevId;
>>          UCHAR ucNumEntries;                                                                             /* Number of entries. */
>> -       ATOM_Tonga_Voltage_Lookup_Record entries[1];                            /* Dynamically allocate entries. */
>> +       ATOM_Tonga_Voltage_Lookup_Record entries[];                             /* Dynamically allocate entries. */
>>   } ATOM_Tonga_Voltage_Lookup_Table;
>>
>>   typedef struct _ATOM_Tonga_Fan_Table {
>> --
>> 2.34.1
>>

